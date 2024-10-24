import 'package:clo2/components/information_card.dart';
import 'package:clo2/pages/information_page.dart';
import 'package:flutter/material.dart';

class BatteryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InformationPage(
      name: "Other",
      tab1Name: "Network 5",
      tab2Name: "Battery 4",
      content1: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InformationCard(name: "Use Wi-Fi Whenever Possible", content: "Wi-Fi is generally more energy efficient than mobile data. Use Wi-Fi when you are at home or in the office."),
          SizedBox(height: 12,),
          InformationCard(name: "Turn Off Connections When Unnecessary", content: "Turn off Wi-Fi, Bluetooth and mobile data when you don't need them. This reduces your phone's power consumption and extends battery life."),
          SizedBox(height: 12,),
          InformationCard(name: "Think About Airplane Mode", content: "Turn on airplane mode when you don't need a connection."),
          SizedBox(height: 12,),
          InformationCard(name: "Favor Ecological Communications", content: "Favor voice or video calls on messaging applications over physical travel when possible, which reduces travel-related carbon emissions."),
          SizedBox(height: 12,),
          InformationCard(name: "Disable Automatic Updates", content: "Turn off automatic app updates on mobile data. Allow updates only when connected to Wi-Fi."),
        ],
      ),
      content2: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InformationCard(name: "Charge Cycle", content: "Try to keep the battery between 20% and 80% charge to extend its life."),
          SizedBox(height: 12,),
          InformationCard(name: "Use Dark Mode", content: "Dark mode consumes less power, especially on OLED displays."),
          SizedBox(height: 12,),
          InformationCard(name: "Reduce Screen Brightness", content: "Screen brightness is one of the main sources of power consumption. Use automatic brightness adjustment or manually reduce your screen brightness to save power and extend battery life."),
          SizedBox(height: 12,),
          InformationCard(name: "Favor Ecological Communications", content: "Favor voice or video calls on messaging applications over physical travel when possible, which reduces travel-related carbon emissions."),
          SizedBox(height: 12,),
          InformationCard(name: "Enable Automatic Power Saving Settings", content: "Set your phone to automatically turn on power saving settings when it detects low battery or heavy usage."),
        ],
      ),
    );
  }
}
