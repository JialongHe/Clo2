import 'package:clo2/main.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:flutter/material.dart';

// TODO: extract the content
class PerformancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double widthRadio = screenWidth / AppTheme.designWidth;
    double heightRadio = screenHeight / AppTheme.designHeigh;
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
                'Eco-Performance',
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
        SizedBox(height: 6,),
        Container(
          height: 170 * widthRadio,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 345 * widthRadio,
                height: 167 * widthRadio,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/performance/level_a.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Text(
                    'CO2: 185 g CO2',
                    style: TextStyle(
                      color: Color(0xFF8A8B87),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 20 / 14,
                    ),
                  )),
              Positioned(
                  bottom: 20,
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Color(0xFF07684B),
                      fontSize: 56,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 65 / 56,
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(height: 6,),
        SizedBox(
          height: 24,
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/performance/error.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                'Note:',
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
        SizedBox(
          width: double.infinity,
          child: Text(
            'There are five levels of Eco-Performance, which range from A (ultra eco-friendly) to E (high carbon emission).',
            style: TextStyle(
              color: Color(0xFF8A8B87),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 16 / 12,
            ),
            softWrap: true,
          ),
        ),
        SizedBox(
          height: 11,
        ),
        Text(
          'A-Ultra eco-friendly:',
          style: TextStyle(
            color: Color(0xFF072100),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 20 / 14,
          ),
        ),
        Text(
          'Less than 200 g CO2/day.',
          style: TextStyle(
            color: Color(0xFF8A8B87),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 20 / 14,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          'B-Eco-friendly:',
          style: TextStyle(
            color: Color(0xFF072100),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 20 / 14,
          ),
        ),
        Text(
          'Between 200 - 500 g CO2/day.',
          style: TextStyle(
            color: Color(0xFF8A8B87),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 20 / 14,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          'C-Neutral:',
          style: TextStyle(
            color: Color(0xFF072100),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 20 / 14,
          ),
        ),
        Text(
          'Between 500 - 1,000 g CO2/day.',
          style: TextStyle(
            color: Color(0xFF8A8B87),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 20 / 14,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          'D-Above average carbon emission:',
          style: TextStyle(
            color: Color(0xFF072100),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 20 / 14,
          ),
        ),
        Text(
          'Between 1,000 - 2,000 g CO2/day.',
          style: TextStyle(
              color: Color(0xFF8A8B87),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 20 / 14),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          'E-High carbon emission:',
          style: TextStyle(
            color: Color(0xFF072100),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 20 / 14,
          ),
        ),
        Text(
          'Above 2,000 g CO2/day.',
          style: TextStyle(
            color: Color(0xFF8A8B87),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 20 / 14,
          ),
        ),
      ],
    );
  }
}
