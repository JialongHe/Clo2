import 'dart:ui';

import 'package:clo2/components/carousel_card.dart';
import 'package:clo2/components/filter_bar.dart';
import 'package:clo2/components/home_header.dart';
import 'package:clo2/components/suggestion_card.dart';
import 'package:clo2/main.dart';
import 'package:clo2/pages/application_page.dart';
import 'package:clo2/pages/battery_page.dart';
import 'package:clo2/pages/performance_page.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:clo2/utils/co2text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  User? user;

  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool carbonUsage = true;
  ScrollController _scrollController = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 346,
          child: Stack(
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
              HomeHeader(),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FilterBar(),
        SizedBox(
          height: 18,
        ),
        Expanded(
            child: Stack(children: [
          SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: AppTheme.horizontalPadding,
                    height: 180,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          width: 364,
                          height: 46,
                          margin: const EdgeInsets.fromLTRB(6, 7, 6, 0),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF07684B),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: carbonUsage ? 0 : null,
                          right: carbonUsage ? null : 0,
                          child: Container(
                            height: 179,
                            width: 376,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: carbonUsage
                                    ? AssetImage('assets/homepage/tab_card.png')
                                    : AssetImage(
                                        'assets/homepage/tab_card2.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 15,
                            right: 52,
                            child: GestureDetector(
                              onTap: () => (this.setState(() {
                                carbonUsage = false;
                              })),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: carbonUsage ? 16 : 18,
                                    width: carbonUsage ? 16 : 18,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: carbonUsage
                                            ? AssetImage(
                                                'assets/homepage/cloud_queue.png')
                                            : AssetImage(
                                                'assets/homepage/cloud_queue2.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  carbonUsage
                                      ? SizedBox(width: 4)
                                      : SizedBox(width: 6),
                                  Text('Cloud Usage',
                                      style: carbonUsage
                                          ? AppTheme.roboto14RegularWhite
                                          : AppTheme.roboto16BoldGreen)
                                ],
                              ),
                            )),
                        Positioned(
                            top: 15,
                            left: 21,
                            child: GestureDetector(
                              onTap: () => (this.setState(() {
                                carbonUsage = true;
                              })),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: carbonUsage ? 18 : 16,
                                    width: carbonUsage ? 18 : 16,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: carbonUsage
                                            ? AssetImage(
                                                'assets/homepage/energy_savings_leaf.png')
                                            : AssetImage(
                                                'assets/homepage/energy_savings_leaf2.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  carbonUsage
                                      ? SizedBox(width: 6)
                                      : SizedBox(width: 4),
                                  Text('Carbon Emission',
                                      style: carbonUsage
                                          ? AppTheme.roboto16BoldGreen
                                          : AppTheme.roboto14RegularWhite)
                                ],
                              ),
                            )),
                        Positioned(
                          left: 21,
                          top: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('4,688', style: AppTheme.roboto28BoldGreen),
                              SizedBox(
                                width: 4,
                              ),
                              Co2text(),
                            ],
                          ),
                        ),
                        Positioned(
                            left: 198,
                            top: 60,
                            child: GestureDetector(
                              onTap: () {
                                final appState =
                                    context.findAncestorStateOfType<
                                        AppContainerState>();

                                if (appState != null) {
                                  appState.toggleDrawer();
                                  appState.updateDrawer(Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          20, 24, 20, 0),
                                      child: PerformancePage()));
                                }
                              },
                              child: SizedBox(
                                height: 36,
                                child: Row(children: [
                                  Text('B', style: AppTheme.roboto28BoldGreen),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Text(
                                    'Level',
                                    style: TextStyle(
                                      color: Color(0xFF07684B),
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Container(
                                    width: 18,
                                    height: 18,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/homepage/error.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            )),
                        Positioned(
                            left: 21,
                            top: 108,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/homepage/cloud_download.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'Download',
                                  style: TextStyle(
                                    color: Color(0xFF8A8B87),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )),
                        Positioned(
                            left: 198,
                            top: 108,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/homepage/cloud_upload.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'Upload',
                                  style: TextStyle(
                                    color: Color(0xFF8A8B87),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )),
                        Positioned(
                          left: 21,
                          top: 131,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '2,000',
                                style: TextStyle(
                                  color: Color(0xFF07684B),
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Co2text(),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 197,
                          top: 131,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '2,688',
                                style: TextStyle(
                                  color: Color(0xFF07684B),
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Co2text(),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 331,
                          top: 133,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/homepage/arrow_circle_right_green.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 138,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CarouselCard(
                              image: 'assets/homepage/car.png',
                              details:
                                  'It is estimated a small car’s carbon emission',
                              number: '2000',
                              unit: 'Km'),
                          SizedBox(
                            width: 12,
                          ),
                          CarouselCard(
                              image: 'assets/homepage/food.png',
                              details:
                                  'It is estimated eqaul to one meal with beef',
                              number: '15.9',
                              unit: 'Kg / beef'),
                          SizedBox(
                            width: 12,
                          ),
                          CarouselCard(
                              image: 'assets/homepage/food.png',
                              details:
                                  'It is estimated eqaul to one meal with beef',
                              number: '15.9',
                              unit: 'Kg / beef'),
                          SizedBox(
                            width: 12,
                          ),
                          CarouselCard(
                              image: 'assets/homepage/food.png',
                              details:
                                  'It is estimated eqaul to one meal with beef',
                              number: '15.9',
                              unit: 'Kg / beef'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 28,
                    padding: AppTheme.horizontalPadding,
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/homepage/leaf.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Suggestions',
                          style: TextStyle(
                            color: Color(0xFF072100),
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 376,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SuggestionCard(
                          image: 'assets/homepage/cloud_sync.png',
                          name: 'Application',
                          detail: '11 related suggestions',
                          linkPage: ApplicationPage(),
                        ),
                        Container(
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SuggestionCard(
                          image: 'assets/homepage/battery_1_bar.png',
                          name: 'Other',
                          detail: '9 related suggestions',
                          linkPage: BatteryPage(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              )),
          if (offset > 0)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                  child: Container(
                height: 45,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.0, 1.00),
                    end: Alignment(-0.0, -1),
                    colors: [Color(0x42F6F2F2), Color(0xFFF4F4F4)],
                  ),
                ),
              )),
            ),
        ]))
      ],
    );
  }
}
