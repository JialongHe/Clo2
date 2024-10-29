import 'package:clo2/components/information_card.dart';
import 'package:clo2/pages/information_page.dart';
import 'package:flutter/material.dart';

class ApplicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InformationPage(
      name: "Application",
      tab1Name: "General 7",
      tab2Name: "Cloud-native 4",
      content1: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 28,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/information/leaf.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  'Application Management',
                  style: TextStyle(
                    color: Color(0xFF07684B),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 24 / 16,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 14,),
          InformationCard(name: "Choosing Environmentally Cloud Services", content: "Use online storage services that are committed to reducing their carbon footprint & using renewable energy sources"),
          SizedBox(height: 12,),
          InformationCard(name: "Favor Open-source Applications", content: "Use open-source applications when possible, as they are often developed with sustainability in mind and can be optimized to reduce resource consumption."),
          SizedBox(height: 12,),
          InformationCard(name: "Download Offline Resources", content: "Use applications that optimize data and power consumption."),
          SizedBox(height: 12,),
          InformationCard(name: "Remove Unnecessary Application", content: "Regularly delete applications that you no longer use. This frees up storage space and allows your phone to work more efficiently."),
          SizedBox(height: 12,),
          InformationCard(name: "Manage Notifications", content: "Disable unnecessary push notifications to reduce power consumption"),
          SizedBox(height: 16,),
          Container(
            height: 28,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/information/leaf.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  'Self-motivation',
                  style: TextStyle(
                    color: Color(0xFF07684B),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 24 / 16,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 14,),
          InformationCard(name: "Setting Your Carbon Budget", content: "Evaluate your daily carbon emission based on cloud storage, data usage and app time, to set a goal to achieve."),
          SizedBox(height: 12,),
          InformationCard(name: "Avoid Excessive In-app Purchases", content: "Limit your purchases of applications and virtual items in games to reduce your digital & save resources.")
        ],
      ),
      content2: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 28,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/information/leaf.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  'Data Management',
                  style: TextStyle(
                    color: Color(0xFF07684B),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 24 / 16,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 14,),
          InformationCard(name: "Clear Unnecessary Files", content: "Use online storage services that are committed to reducing their carbon footprint & using renewable energy sources."),
          SizedBox(height: 12,),
          InformationCard(name: "Data Usage Reduction", content: "Automatically lower video streaming resolution, delay cloud sync or backup to lower carbon periods and disable automatic app updates."),
          SizedBox(height: 12,),
          InformationCard(name: "Use File Compression", content: "Use open-source applications when possible, as they are often developed with sustainability in mind and can be optimized to reduce resource consumption."),
          SizedBox(height: 16,),
          Container(
            height: 28,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/information/leaf.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  'Choosing Environmentally Cloud Services',
                  style: TextStyle(
                    color: Color(0xFF07684B),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 24 / 14,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 14,),
          InformationCard(name: "Choosing Environmentally Cloud Services", content: "Suggest switching to cloud services that use renewable energy such as Google Cloud’s carbon-neutral services or AWS’s sustainability features."),
        ],
      ),
    );
  }
}
