import 'package:intl/intl.dart';
import 'dart:convert';

class CarbonCalculator {
  static const double _bytesPerGB = 1e9; // 1 GB = 1,000,000,000 bytes
  static const double _co2PerGBHour = 5; // CO₂ emission in grams per GB-hour stored

  static double convertStorageToGB(double storageUsageInBytes) {
    return storageUsageInBytes / _bytesPerGB;
  }

  static double convertGbToCO2(double gb) {
    return gb * _co2PerGBHour;
  }

  /// Converts storage usage (in bytes) to grams of CO₂ equivalent (g CO₂ e).
  static double convertStorageToCO2(double storageUsageInBytes) {
    double storageInGB = storageUsageInBytes / _bytesPerGB;
    return storageInGB * _co2PerGBHour;
  }

  /// Formats the carbon impact to a string with units for display.
  static String formatCO2Output(double co2Value) {
    final numberFormat = NumberFormat("#,##0.00");
    return numberFormat.format(co2Value); // e.g., "1,234 g CO₂ e"
  }

  static double parseTotalUsageFromStorage(String storageUsage) {
    final parsedData = jsonDecode(storageUsage);
    return double.parse(parsedData['storageQuota']['usage']);
  }

  static double parseDriveUsageFromStorage(String storageUsage) {
    final parsedData = jsonDecode(storageUsage);
    return double.parse(parsedData['storageQuota']['usageInDrive']);
  }

  static double parseDriveTrashUsageFromStorage(String storageUsage) {
    final parsedData = jsonDecode(storageUsage);
    return double.parse(parsedData['storageQuota']['usageInDriveTrash']);
  }

  static double parseGmailUsageFromStorage(String storageUsage) {
    return parseTotalUsageFromStorage(storageUsage) -
        parseDriveUsageFromStorage(storageUsage) - parseDriveTrashUsageFromStorage(storageUsage);
  }

  static double parseNetworkUpload(String networkUsage) {
    final parsedData = jsonDecode(networkUsage);
    
    final transmitted = double.parse(parsedData['transmitted'].toString());
    return transmitted;
  }

  static double parseNetworkDownload(String networkUsage) {
    final parsedData = jsonDecode(networkUsage);
    final received = double.parse(parsedData['received'].toString());
    return received;
  }

  static double parseNetworkTotalUsage(String networkUsage) {
    final parsedData = jsonDecode(networkUsage);
    final received = double.parse(parsedData['received'].toString());
    final transmitted = double.parse(parsedData['transmitted'].toString());
    return received + transmitted;
  }
}
