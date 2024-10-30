package com.example.clo2

import android.app.AppOpsManager
import android.app.usage.NetworkStats
import android.app.usage.NetworkStatsManager
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import android.net.TrafficStats
import android.os.BatteryManager
import android.os.Bundle
import android.os.RemoteException
import android.provider.Settings
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.pm.PackageManager

class MainActivity : FlutterActivity() {

    private val NETWORK_CHANNEL = "com.example.clo2/networkUsage"
    private val BATTERY_CHANNEL = "com.example.clo2/batteryInfo"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Method channel for network usage
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NETWORK_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getNetworkUsage") {
                val received = TrafficStats.getTotalRxBytes()
                val transmitted = TrafficStats.getTotalTxBytes()
                if (received == TrafficStats.UNSUPPORTED.toLong() || transmitted == TrafficStats.UNSUPPORTED.toLong()) {
                    result.error("UNAVAILABLE", "Network data not supported", null)
                } else {
                    result.success(mapOf("received" to received, "transmitted" to transmitted))
                }
            } else if (call.method == "getAllAppsNetworkUsage") {
                val startTime = call.argument<Long>("startTime") ?: System.currentTimeMillis() - 24 * 60 * 60 * 1000
                val endTime = call.argument<Long>("endTime") ?: System.currentTimeMillis()
                if (hasUsageStatsPermission(this)) {
                    val usageData = getAllAppsNetworkUsage(startTime, endTime)
                    result.success(usageData)
                } else {
                    requestUsageStatsPermission(this)
                    result.error("PERMISSION_DENIED", "Usage access permission not granted", null)
                }
            } else {
                result.notImplemented()
            }
        }

        // Method channel for battery info
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryInfo") {
                val batteryStatus: Intent? = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { ifilter ->
                    applicationContext.registerReceiver(null, ifilter)
                }
                batteryStatus?.let {
                    val level = it.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                    val scale = it.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
                    val isCharging = it.getIntExtra(BatteryManager.EXTRA_STATUS, -1) == BatteryManager.BATTERY_STATUS_CHARGING
                    val batteryPercentage = level * 100 / scale.toFloat()
                    result.success(mapOf("level" to batteryPercentage, "isCharging" to isCharging))
                } ?: result.error("UNAVAILABLE", "Battery info not available", null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getAllAppsNetworkUsage(startTime: Long, endTime: Long): List<Map<String, Any>> {
        val networkStatsManager = getSystemService(Context.NETWORK_STATS_SERVICE) as NetworkStatsManager
        val packageManager = packageManager
        val appUsageData = mutableListOf<Map<String, Any>>()
        val apps = packageManager.getInstalledApplications(PackageManager.GET_META_DATA)

        for (appInfo in apps) {
            val appName = appInfo.loadLabel(packageManager).toString()
            val packageName = appInfo.packageName

            try {
                val uid = appInfo.uid
                val mobileUsage = getNetworkUsageForUid(networkStatsManager, ConnectivityManager.TYPE_MOBILE, uid, startTime, endTime)
                val wifiUsage = getNetworkUsageForUid(networkStatsManager, ConnectivityManager.TYPE_WIFI, uid, startTime, endTime)

                appUsageData.add(
                    mapOf(
                        "appName" to appName,
                        "packageName" to packageName,
                        "mobileUsage" to mobileUsage,
                        "wifiUsage" to wifiUsage
                    )
                )

            } catch (e: SecurityException) {
                e.printStackTrace()  // Log but skip apps with restricted permissions
                continue
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }

        return appUsageData
    }

    private fun getNetworkUsageForUid(networkStatsManager: NetworkStatsManager, networkType: Int, uid: Int, startTime: Long, endTime: Long): Long {
        var usage = 0L
        try {
            val networkStats = networkStatsManager.queryDetailsForUid(networkType, null, startTime, endTime, uid)
            val bucket = NetworkStats.Bucket()
            while (networkStats.hasNextBucket()) {
                networkStats.getNextBucket(bucket)
                usage += bucket.rxBytes + bucket.txBytes
            }
            networkStats.close()
        } catch (e: RemoteException) {
            e.printStackTrace()
        }
        return usage
    }

    // Check if Usage Access is granted
    private fun hasUsageStatsPermission(context: Context): Boolean {
        val appOps = context.getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = appOps.checkOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, android.os.Process.myUid(), context.packageName)
        return mode == AppOpsManager.MODE_ALLOWED
    }

    // Request Usage Access Permission
    private fun requestUsageStatsPermission(context: Context) {
        if (!hasUsageStatsPermission(context)) {
            Toast.makeText(context, "Please enable usage access permission for this app.", Toast.LENGTH_LONG).show()
            val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            startActivity(intent)
        }
    }
}