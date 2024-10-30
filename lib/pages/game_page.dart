import 'package:clo2/components/goal_card.dart';
import 'package:clo2/main.dart';
import 'package:clo2/pages/certificate_page.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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

  List<Image> levelTrees = [
    Image.asset(
      width: 196,
      height: 158,
      'assets/gamification/level1.png',
    ),
    Image.asset(
      width: 196,
      height: 179,
      'assets/gamification/level2.png',
    ),
    Image.asset(
      width: 238,
      height: 239,
      'assets/gamification/level3.png',
    ),
    Image.asset(
      width: 252,
      height: 242,
      'assets/gamification/level4.png',
    ),
    Image.asset(
      width: 241,
      height: 242,
      'assets/gamification/level5.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double widthRadio = screenWidth / AppTheme.designWidth;
    double heightRadio = screenHeight / AppTheme.designHeigh;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/gamification/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 66,
              child: Container(
                width: screenWidth - 36,
                height: 78,
                margin: EdgeInsets.symmetric(horizontal: 18),
                child: Stack(
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/gamification/header_background.png'),
                        fit: BoxFit.cover,
                      ),
                    )),
                    Positioned(
                        top: 9,
                        left: 11,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/gamification/keyboard_arrow_left.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'My tree',
                                style: TextStyle(
                                  color: Color(0xFF07684B),
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        )),
                    Positioned(
                        left: 12,
                        top: 47,
                        child: Container(
                          width: (screenWidth - 64) * widthRadio,
                          height: 20,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFDEFDB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        )),
                    Positioned(
                        left: 12,
                        top: 47,
                        child: Container(
                          width: 140,
                          height: 20,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFE970F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        )),
                    Positioned(
                      top: 47,
                      left: 12,
                      child: Container(
                          height: 20,
                          width: screenWidth - 100,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 12,
                              ),
                              const Text(
                                'Lv. 1',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    height: 16 / 12),
                              ),
                              Spacer(),
                              Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/gamification/cloud_circle.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.only(left: 2),
                                child: Text(
                                  '200/500',
                                  style: TextStyle(
                                    color: Color(0xFF51330C),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15)
                            ],
                          )),
                    ),
                    Positioned(
                      top: 42,
                      right: 14,
                      child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/gamification/final.png'),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    Positioned(
                        right: 0,
                        child: Container(
                            width: 95,
                            height: 28,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: ShapeDecoration(
                              color: Color(0xFF07684B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
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
                                      child: CertificatePage()));
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 16,
                                      height: 16,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/gamification/badge.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    '02 /12',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ))),
                  ],
                ),
              )),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
                width: screenWidth,
                height: 440,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: levelTrees[0],
                    )
                  ],
                )),
          ),
          Positioned(
              top: 453,
              child: Container(
                  width: screenWidth - 32,
                  height: screenHeight - 453,
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Container(
                          height: 143,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 28,
                                margin: EdgeInsets.fromLTRB(15, 14, 15, 0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Credit History',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'More',
                                      style: TextStyle(
                                        color: Color(0xFF8A8B87),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                        width: 18,
                                        height: 18,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/gamification/arrow_circle_right.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                height: 71,
                                margin: EdgeInsets.fromLTRB(22, 9, 15, 21),
                                child: Row(
                                  children: [
                                    // TODO: Extract the progress bar
                                    Container(
                                      width: 12,
                                      height: 71,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 6.5,
                                            child: Transform(
                                              transform: Matrix4.identity()
                                                ..translate(0.0, 0.0)
                                                ..rotateZ(1.57),
                                              child: Container(
                                                width: 60,
                                                decoration: ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      width: 2,
                                                      strokeAlign: BorderSide
                                                          .strokeAlignCenter,
                                                      color: Color(0xFF07684B),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFFEDF6E9),
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                      width: 2,
                                                      color: Color(0xFF07684B)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 11,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '30 July  18:00:00',
                                          style: TextStyle(
                                            color: Color(0xFFBDBDBD),
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 16 / 12,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          'Clean the Data in Google Cloud ',
                                          style: TextStyle(
                                            color: Color(0xFF072100),
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w700,
                                            height: 24 / 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          'Decrease the 30g CO2e/day. ',
                                          style: TextStyle(
                                            color: Color(0xFF8A8B87),
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      '+50',
                                      style: TextStyle(
                                        color: Color(0xFF51330C),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                        width: 16,
                                        height: 16,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/gamification/cloud_circle.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          width: screenWidth - 36,
                          // height: 362,
                          padding: EdgeInsets.all(15),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Carbon Goal',
                                style: TextStyle(
                                  color: Color(0xFF072100),
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 14),
                              GoalCard(
                                  leftImage:
                                      "assets/gamification/dark_mode.png",
                                  name: "Activate the Eco-Mode",
                                  capacity: 50,
                                  progess: 50,
                                  rightImage: "assets/gamification/credit.png"),
                              GoalCard(
                                  leftImage:
                                      "assets/gamification/cloud_download.png",
                                  name: "Delete unused files on google drive",
                                  capacity: 50,
                                  progess: 5,
                                  rightImage: "assets/gamification/check.png"),
                              GoalCard(
                                  leftImage:
                                      "assets/gamification/cloud_download.png",
                                  name: "Accomplish Carbon Budget",
                                  capacity: 50,
                                  progess: 10,
                                  rightImage: "assets/gamification/check.png"),
                              GoalCard(
                                  leftImage:
                                      "assets/gamification/cloud_download.png",
                                  name: "Accomplish Carbon Budget",
                                  capacity: 50,
                                  progess: 25,
                                  rightImage: "assets/gamification/check.png"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))),
          if (offset > 10)
            Positioned(
              top: 453,
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
        ],
      ),
    );
  }
}
