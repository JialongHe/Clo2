package com.example.clo2

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
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val NETWORK_CHANNEL = "com.example.clo2/networkUsage"
    private val BATTERY_CHANNEL = "com.example.clo2/batteryInfo"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Basic network usage using TrafficStats
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NETWORK_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getNetworkUsage") {
                val received = TrafficStats.getTotalRxBytes() // Total data received
                val transmitted = TrafficStats.getTotalTxBytes() // Total data transmitted
                if (received == TrafficStats.UNSUPPORTED.toLong() || transmitted == TrafficStats.UNSUPPORTED.toLong()) {
                    result.error("UNAVAILABLE", "Network data not supported", null)
                } else {
                    result.success(mapOf("received" to received, "transmitted" to transmitted))
                }
            } else if (call.method == "getAppNetworkUsage") {
                // Detailed network usage using NetworkStatsManager
                val packageName = call.argument<String>("packageName") ?: ""
                val usageData = getAppNetworkUsage(packageName)
                result.success(usageData)
            } else {
                result.notImplemented()
            }
        }

        // Battery info
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

    // Helper method to get app-specific network usage data
    private fun getAppNetworkUsage(packageName: String): Map<String, Long> {
        val networkStatsManager = getSystemService(Context.NETWORK_STATS_SERVICE) as NetworkStatsManager
        val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        val endTime = System.currentTimeMillis()
        val startTime = endTime - 24 * 60 * 60 * 1000 // e.g., last 24 hours

        var mobileUsage = 0L
        var wifiUsage = 0L

        try {
            // Get mobile usage
            val mobileStats = networkStatsManager.querySummary(
                ConnectivityManager.TYPE_MOBILE, null, startTime, endTime
            )
            mobileUsage = getNetworkUsageForApp(mobileStats, packageName)

            // Get Wi-Fi usage
            val wifiStats = networkStatsManager.querySummary(
                ConnectivityManager.TYPE_WIFI, null, startTime, endTime
            )
            wifiUsage = getNetworkUsageForApp(wifiStats, packageName)

        } catch (e: RemoteException) {
            e.printStackTrace()
        }

        return mapOf("mobileUsage" to mobileUsage, "wifiUsage" to wifiUsage)
    }

    private fun getNetworkUsageForApp(networkStats: NetworkStats, packageName: String): Long {
        var usage = 0L
        val uid = try {
            packageManager.getApplicationInfo(packageName, 0).uid
        } catch (e: Exception) {
            e.printStackTrace()
            return usage // Return 0 if package not found
        }

        val entry = NetworkStats.Bucket()
        while (networkStats.hasNextBucket()) {
            networkStats.getNextBucket(entry)
            if (entry.uid == uid) {
                usage += entry.rxBytes + entry.txBytes
            }
        }
        networkStats.close()
        return usage
    }
}