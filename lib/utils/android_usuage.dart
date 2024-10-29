import 'package:flutter/services.dart';

class AndroidUsage {
  static const MethodChannel _networkChannel = MethodChannel('com.example.clo2/networkUsage');
  static const MethodChannel _batteryChannel = MethodChannel('com.example.clo2/batteryInfo');

  // Method to get network usage
  static Future<Map<String, int>> getNetworkUsage() async {
    try {
      final result = await _networkChannel.invokeMapMethod<String, int>('getNetworkUsage') ?? {};
      return result;
    } on PlatformException catch (e) {
      print("Failed to get network usage: '${e.message}'.");
      return {};
    }
  }

  // Method to get battery info
  static Future<Map<String, dynamic>> getBatteryInfo() async {
    try {
      final result = await _batteryChannel.invokeMapMethod<String, dynamic>('getBatteryInfo') ?? {};
      return result;
    } on PlatformException catch (e) {
      print("Failed to get battery info: '${e.message}'.");
      return {};
    }
  }
}
