import 'dart:convert';

import 'package:flutter/services.dart';

class AndroidUsage {
  static const MethodChannel _networkChannel =
      MethodChannel('com.example.clo2/networkUsage');
  static const MethodChannel _batteryChannel =
      MethodChannel('com.example.clo2/batteryInfo');

  // Method to get network usage
  static Future<String> getNetworkUsage() async {
    try {
      final result = await _networkChannel
              .invokeMapMethod<String, int>('getNetworkUsage') ??
          {};
      return jsonEncode(result);
    } on PlatformException catch (e) {
      print("Failed to get network usage: '${e.message}'.");
      return "";
    }
  }

  static Future<String> getAllAppsNetworkUsage(int startTime, int endTime) async {
    try {
      final List<dynamic> allAppData = await _networkChannel.invokeMethod(
        'getAllAppsNetworkUsage',
        {"startTime": startTime, "endTime": endTime},
      );
      return jsonEncode(allAppData);
    } catch (e) {
      print('Error retrieving all apps network usage: $e');
      return "";
    }
  }

  // static Future<Map<String, int>> getAppNetworkUsage() async {
  //   try {
  //     final result = await _networkChannel
  //             .invokeMapMethod<String, int>('getAppNetworkUsage') ??
  //         {};
  //     return result;
  //   } on PlatformException catch (e) {
  //     print("Failed to get network usage: '${e.message}'.");
  //     return {};
  //   }
  // }

  // Method to get battery info
  static Future<Map<String, dynamic>> getBatteryInfo() async {
    try {
      final result = await _batteryChannel
              .invokeMapMethod<String, dynamic>('getBatteryInfo') ??
          {};
      return result;
    } on PlatformException catch (e) {
      print("Failed to get battery info: '${e.message}'.");
      return {};
    }
  }
}
