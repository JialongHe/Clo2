// google_api_service.dart
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart'; // Update path as needed

class GoogleApiService {
  Future<String?> fetchStorageUsage(BuildContext context) async {
    final accessToken = await context.read<UserProvider>().getAccessToken();
    if (accessToken != null) {
      final response = await http.get(
        Uri.parse('https://www.googleapis.com/drive/v3/about?fields=storageQuota'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final storageQuota = response.body;
        print("Storage Usage Data: $storageQuota");
        return storageQuota;
      } else {
        print('Failed to fetch storage usage data: ${response.statusCode}');
      }
    } else {
      print("Access token is not available");
    }
  }
}
