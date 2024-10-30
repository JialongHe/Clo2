import 'package:clo2/components/badge_card.dart';
import 'package:clo2/main.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CertificatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double widthRadio = screenWidth / AppTheme.designWidth;
    final appState = context.findAncestorStateOfType<AppContainerState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 28,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Certificate',
                style: TextStyle(
                  color: Color(0xFF072100),
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 28 / 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  appState!.toggleDrawer();
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/drawer/close.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BadgeCard(
                    image: 'assets/certificate/timber.png', name: "Timber"),
                BadgeCard(
                    image: 'assets/certificate/cherry.png', name: "Cherry"),
                BadgeCard(
                    image: 'assets/certificate/blank.png', name: "Pine"),
              ],
            ),
            SizedBox(height: 22,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BadgeCard(
                    image: 'assets/certificate/blank.png', name: "Pine"),
                BadgeCard(
                    image: 'assets/certificate/blank.png', name: "Pine"),
                BadgeCard(
                    image: 'assets/certificate/blank.png', name: "Pine"),
              ],
            ),
            SizedBox(height: 22,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BadgeCard(
                    image: 'assets/certificate/blank.png', name: "Pine"),
                BadgeCard(
                    image: 'assets/certificate/blank.png', name: "Pine"),
                BadgeCard(
                    image: 'assets/certificate/blank.png', name: "Pine"),
              ],
            ),
          ],
        ))
      ],
    );
  }
}
