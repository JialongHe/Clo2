import 'dart:convert';

import 'package:clo2/components/dashline.dart';
import 'package:clo2/components/data_card.dart';
import 'package:clo2/components/filter_bar.dart';
import 'package:clo2/components/usage_card.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:clo2/utils/carbon_calculator.dart';
import 'package:clo2/utils/co2text.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  String storageUsage;
  String netUsage;
  String appNetworkUsage;

  DashBoardPage(
      {required this.appNetworkUsage,
      required this.netUsage,
      required this.storageUsage});

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  ScrollController _scrollController = ScrollController();
  double offset = 0;
  String? storageUsage;
  String? netUsage;
  String? appNetworkUsage;
  dynamic top10Apps;

  @override
  void initState() {
    super.initState();

    this.storageUsage = widget.storageUsage;
    this.netUsage = widget.netUsage;
    this.appNetworkUsage = widget.appNetworkUsage;
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

  void calculateAndRankTopUsage(List appNetworkUsage) {
    for (var app in appNetworkUsage) {
      app['totalUsage'] = app['mobileUsage'] + app['wifiUsage'];
    }

    appNetworkUsage.sort((a, b) => b['totalUsage'].compareTo(a['totalUsage']));

    top10Apps = appNetworkUsage.take(10).map((entry) {
      return {
        "appName": entry["appName"],
        "totalUsage": entry["totalUsage"],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double widthRadio = screenWidth / AppTheme.designWidth;

    double storageCO2 = storageUsage != null
        ? CarbonCalculator.convertStorageToCO2(
            CarbonCalculator.parseTotalUsageFromStorage(storageUsage!))
        : 0;
    double netCO2 = netUsage != null
        ? CarbonCalculator.convertStorageToCO2(
            CarbonCalculator.parseNetworkTotalUsage(netUsage!))
        : 0;

    List driveCO2 = storageUsage != null
        ? [
            CarbonCalculator.convertStorageToCO2(
                CarbonCalculator.parseDriveUsageFromStorage(storageUsage!)),
            CarbonCalculator.convertStorageToCO2(
                CarbonCalculator.parseDriveTrashUsageFromStorage(
                    storageUsage!)),
            CarbonCalculator.convertStorageToCO2(
                CarbonCalculator.parseGmailUsageFromStorage(storageUsage!)),
          ]
        : [0, 0, 0];

    calculateAndRankTopUsage(
        appNetworkUsage != null ? jsonDecode(appNetworkUsage!) : []);

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
                                  left: 130,
                                  child: Container(
                                    width: 69,
                                    height: 48,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          CarbonCalculator.formatCO2Output(
                                              storageCO2 + netCO2),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w700,
                                            height: 24 / 18,
                                          ),
                                        ),
                                        const SizedBox(
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
                                        const Text(
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
                                                CarbonCalculator
                                                    .formatCO2Output(netCO2),
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
                                                CarbonCalculator
                                                    .formatCO2Output(
                                                        storageCO2),
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
                                                '0',
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
                                usage: CarbonCalculator.formatCO2Output(
                                    storageCO2),
                                name: "Total",
                                percent: 1,
                                bold: true,
                              ),
                              const SizedBox(height: 4),
                              ...() {
                                // Pair each driveCO2 value with a name
                                List<Map<String, dynamic>> dataList = [
                                  {"name": "Google Drive", "co2": driveCO2[0]},
                                  {
                                    "name": "Google Drive Trash",
                                    "co2": driveCO2[1]
                                  },
                                  {"name": "Gmail", "co2": driveCO2[2]},
                                ];

                                // Sort by the CO2 values in descending order
                                dataList.sort(
                                    (a, b) => b["co2"].compareTo(a["co2"]));

                                // Generate UsageCards with SizedBoxes between them
                                return List.generate(dataList.length * 2 - 1,
                                    (index) {
                                  if (index.isOdd) {
                                    return const SizedBox(height: 4);
                                  } else {
                                    int dataIndex = index ~/ 2;
                                    return UsageCard(
                                      usage: CarbonCalculator.formatCO2Output(
                                          dataList[dataIndex]["co2"]),
                                      name: dataList[dataIndex]["name"],
                                      percent: dataList[dataIndex]["co2"] /
                                          storageCO2,
                                      bold: false,
                                    );
                                  }
                                });
                              }(),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: top10Apps != null
                                ? Column(
                                    children: List.generate(
                                        top10Apps.length * 2 - 1, (index) {
                                      if (index.isOdd) {
                                        return Dashline();
                                      } else {
                                        int dataIndex = index ~/ 2;
                                        double gb =
                                            CarbonCalculator.convertStorageToGB(
                                                double.parse(
                                                    top10Apps[dataIndex]
                                                            ["totalUsage"]
                                                        .toString()));
                                        return DataCard(
                                          name: top10Apps[dataIndex]["appName"],
                                          bandWidth: gb,
                                        );
                                      }
                                    }),
                                  )
                                : Container())
                      ],
                    ),
                  )),
              if (offset > 10)
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
