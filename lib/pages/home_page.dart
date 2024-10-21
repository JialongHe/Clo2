import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 312,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/homepage/topBackgroud.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
