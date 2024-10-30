import 'package:clo2/components/dashline.dart';
import 'package:clo2/components/data_card.dart';
import 'package:clo2/components/filter_bar.dart';
import 'package:clo2/components/usage_card.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:clo2/utils/co2text.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  DashBoardPage();

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  ScrollController _scrollController = ScrollController();
  double offset = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double widthRadio = screenWidth / AppTheme.designWidth;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: screenWidth,
            height: 108,
            decoration: BoxDecoration(color: Colors.white),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 28,
                margin: const EdgeInsets.fromLTRB(20, 62, 0, 0),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/dashboard/keyboard_arrow_left.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Color(0xFF072100),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 28 / 18,
                      ),
                    )
                  ],
                ),
              ),
            )),
        const SizedBox(
          height: 18,
        ),
        FilterBar(),
        const SizedBox(height: 23),
        Expanded(
          child: Stack(
            children: [
              Container(
                  width: screenWidth,
                  height: screenHeight - 181,
                  // decoration: BoxDecoration(color: Colors.red),
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                          child: Row(
                            children: [
                              Container(
                                height: 18,
                                width: 18,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/homepage/energy_savings_leaf.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Carbon Emission',
                                style: TextStyle(
                                  color: Color(0xFF07684B),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  height: 24 / 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 235,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 24,
                                left: 97,
                                child: Container(
                                  height: 136,
                                  width: 136,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/dashboard/donut.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 69,
                                left: 77,
                                child: Container(
                                  height: 10.5,
                                  width: 56.5,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/dashboard/point_top_left.png'),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 69,
                                left: 221,
                                child: Container(
                                  height: 21.5,
                                  width: 55.5,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/dashboard/point_right.png'),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 151.5,
                                left: 77,
                                child: Container(
                                  height: 8.5,
                                  width: 96.5,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/dashboard/point_bottom_left.png'),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 70,
                                  left: 135,
                                  child: Container(
                                    width: 62,
                                    height: 48,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '4,688',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w700,
                                            height: 28 / 24,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Co2text()
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 14,
                                  left: 16,
                                  child: SizedBox(
                                    width: 88,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Data\nTransmission',
                                          style: TextStyle(
                                            color: Color(0xFF072100),
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 20 / 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          height: 24,
                                          child: Row(
                                            children: [
                                              Text(
                                                '2,688',
                                                style: TextStyle(
                                                  color: Color(0xFF072100),
                                                  fontSize: 16,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w700,
                                                  height: 24 / 16,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'g',
                                                style: TextStyle(
                                                  color: Color(0xFF8A8B87),
                                                  fontSize: 11,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                  height: 12 / 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 70,
                                  left: 235,
                                  child: SizedBox(
                                    width: 80,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Cloud Usage',
                                          style: TextStyle(
                                            color: Color(0xFF072100),
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 20 / 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          height: 24,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '2,000',
                                                style: TextStyle(
                                                  color: Color(0xFF072100),
                                                  fontSize: 16,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w700,
                                                  height: 24 / 16,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'g',
                                                style: TextStyle(
                                                  color: Color(0xFF8A8B87),
                                                  fontSize: 11,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                  height: 12 / 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 118,
                                  left: 17,
                                  child: SizedBox(
                                    width: 88,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Other',
                                          style: TextStyle(
                                            color: Color(0xFF072100),
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 20 / 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          height: 24,
                                          child: Row(
                                            children: [
                                              Text(
                                                '200',
                                                style: TextStyle(
                                                  color: Color(0xFF072100),
                                                  fontSize: 16,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w700,
                                                  height: 24 / 16,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'g',
                                                style: TextStyle(
                                                  color: Color(0xFF8A8B87),
                                                  fontSize: 11,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                  height: 12 / 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  left: 17,
                                  top: 175,
                                  child: Container(
                                    height: 24,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 18,
                                          width: 18,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/performance/error.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const Text(
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
                                  )),
                              const Positioned(
                                left: 17,
                                top: 203,
                                child: Text(
                                  'Other includes energy consumption and charging.',
                                  style: TextStyle(
                                    color: Color(0xFF8A8B87),
                                    fontSize: 13,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 16 / 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          height: 24,
                          child: Row(
                            children: [
                              Container(
                                height: 18,
                                width: 18,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/homepage/cloud_queue2.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Cloud Usage',
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
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 224,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 18),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UsageCard(
                                  usage: "1200",
                                  name: "Cloud Storages",
                                  percent: 0.5,
                                  bold: true),
                              SizedBox(
                                height: 4,
                              ),
                              UsageCard(
                                  usage: "2400",
                                  name: "Cloud Transmission",
                                  percent: 1,
                                  bold: false),
                              SizedBox(
                                height: 4,
                              ),
                              UsageCard(
                                  usage: "2400",
                                  name: "Cloud Transmission",
                                  percent: 1,
                                  bold: false),
                              SizedBox(
                                height: 4,
                              ),
                              UsageCard(
                                  usage: "2400",
                                  name: "Cloud Transmission",
                                  percent: 1,
                                  bold: false),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          height: 24,
                          child: Row(
                            children: [
                              Container(
                                height: 18,
                                width: 18,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/dashboard/data_exploration.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Data Usage',
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
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 464,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Column(
                            children: [
                              DataCard(
                                name: "Google Drive",
                                bandWith: "1200",
                              ),
                              Dashline(),
                              DataCard(
                                name: "Spotify",
                                bandWith: "1600",
                              ),
                              Dashline(),
                              DataCard(
                                name: "Spotify",
                                bandWith: "1600",
                              ),
                              Dashline(),
                              DataCard(
                                name: "Spotify",
                                bandWith: "1600",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              if (offset > 0)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                      child: Container(
                    height: 55,
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
        )
      ],
    );
  }
}
