import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:clo2/components/carousel_card.dart';
import 'package:clo2/components/dashline.dart';
import 'package:clo2/components/filter_bar.dart';
import 'package:clo2/components/home_header.dart';
import 'package:clo2/components/suggestion_card.dart';
import 'package:clo2/main.dart';
import 'package:clo2/pages/application_page.dart';
import 'package:clo2/pages/battery_page.dart';
import 'package:clo2/pages/dashboard_page.dart';
import 'package:clo2/pages/performance_page.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:clo2/utils/android_usuage.dart';
import 'package:clo2/utils/carbon_calculator.dart';
import 'package:clo2/utils/co2text.dart';
import 'package:clo2/utils/google_api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  User? user;

  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool cloudData = true;
  ScrollController _scrollController = ScrollController();
  double offset = 0;
  final GoogleApiService _apiService = GoogleApiService();
  String? storageUsage;
  String? netUsage;
  String? appNetworkUsage;
  Timer? _storageUpdateTimer;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _fetchStorageUsageData();
      _storageUpdateTimer = Timer.periodic(Duration(seconds: 30), (timer) {
        _fetchStorageUsageData();
      });
    }
    if (!kIsWeb && Platform.isAndroid) {
      _fetchNetworkUsage();
      // _fetchBatteryInfo();
    }

    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset;
        _storageUpdateTimer?.cancel();
      });
    });
  }

  Future<void> _fetchStorageUsageData() async {
    storageUsage = await _apiService.fetchStorageUsage(context);
    setState(() {
    });
  }

  Future<void> _fetchNetworkUsage() async {
    netUsage = await AndroidUsage.getNetworkUsage();

    final int endTime = DateTime.now().millisecondsSinceEpoch;
    final int startTime = endTime - (24 * 60 * 60 * 1000); // Last 24 hours
    appNetworkUsage =
        await AndroidUsage.getAllAppsNetworkUsage(startTime, endTime);
    setState(() {
    });
  }

  // Future<void> _fetchBatteryInfo() async {
  //   final info = await AndroidUsage.getBatteryInfo();
  //   setState(() {
  //     // batteryInfo = info;
  //   });
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double widthRadio = screenWidth / AppTheme.designWidth;
    double storageCO2 = storageUsage != null
        ? CarbonCalculator.convertStorageToCO2(
            CarbonCalculator.parseTotalUsageFromStorage(storageUsage!))
        : 0;
    double netCO2 = netUsage != null
        ? CarbonCalculator.convertStorageToCO2(
            CarbonCalculator.parseNetworkTotalUsage(netUsage!))
        : 0;

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
                          left: cloudData ? 0 : null,
                          right: cloudData ? null : 0,
                          child: Container(
                            height: 179,
                            width: 376 * widthRadio,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: cloudData
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
                            right:
                                cloudData ? 21 * widthRadio : 36 * widthRadio,
                            child: GestureDetector(
                              onTap: () => (this.setState(() {
                                cloudData = false;
                              })),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: cloudData ? 16 : 18,
                                    width: cloudData ? 16 : 18,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: cloudData
                                            ? AssetImage(
                                                'assets/homepage/energy_savings_leaf2.png')
                                            : AssetImage(
                                                'assets/homepage/energy_savings_leaf.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  cloudData
                                      ? SizedBox(width: 4)
                                      : SizedBox(width: 6),
                                  Text('Data Usage',
                                      style: cloudData
                                          ? AppTheme.roboto14RegularWhite
                                          : AppTheme.roboto14BoldGreen)
                                ],
                              ),
                            )),
                        Positioned(
                            top: 15,
                            left: 22,
                            child: GestureDetector(
                              onTap: () => (this.setState(() {
                                cloudData = true;
                              })),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: cloudData ? 18 : 16,
                                    width: cloudData ? 18 : 16,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: cloudData
                                            ? AssetImage(
                                                'assets/homepage/cloud_queue2.png')
                                            : AssetImage(
                                                'assets/homepage/cloud_queue.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  cloudData
                                      ? SizedBox(width: 6)
                                      : SizedBox(width: 4),
                                  Text('Cloud Usage',
                                      style: cloudData
                                          ? AppTheme.roboto14BoldGreen
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
                              cloudData
                                  ? Text(
                                      CarbonCalculator.formatCO2Output(
                                          storageCO2),
                                      style: AppTheme.roboto28BoldGreen)
                                  : Text(
                                      CarbonCalculator.formatCO2Output(netCO2),
                                      style: AppTheme.roboto28BoldGreen),
                              SizedBox(
                                width: 4,
                              ),
                              Co2text(),
                            ],
                          ),
                        ),
                        if (cloudData) ...[
                          const Positioned(
                              left: 21,
                              top: 105,
                              child: Text(
                                'Storage',
                                style: TextStyle(
                                  color: Color(0xFF8A8B87),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 20 / 14,
                                ),
                              )),
                          Positioned(
                              left: 21,
                              top: 132,
                              child: Container(
                                height: 28,
                                child: Row(
                                  children: [
                                    Text(
                                      storageUsage != null
                                          ? CarbonCalculator.formatCO2Output(
                                              CarbonCalculator.convertStorageToGB(
                                                  CarbonCalculator
                                                      .parseTotalUsageFromStorage(
                                                          storageUsage!)))
                                          : "0",
                                      style: const TextStyle(
                                        color: Color(0xFF07684B),
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                        height: 28 / 18,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'GB',
                                      style: TextStyle(
                                        color: Color(0xFF07684B),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 14 / 12,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Positioned(
                              top: 105,
                              left: 183.1 * widthRadio,
                              child: const Text(
                                'Eco Performance',
                                style: TextStyle(
                                  color: Color(0xFF8A8B87),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 20 / 14,
                                ),
                              )),
                          Positioned(
                              left: 183.1 * widthRadio,
                              top: 126,
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
                                    Text('A',
                                        style: AppTheme.roboto28BoldGreen),
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
                        ],
                        if (!cloudData) ...[
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
                              left: 198 * widthRadio,
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
                                  netUsage != null
                                      ? CarbonCalculator.formatCO2Output(
                                          CarbonCalculator.convertStorageToGB(
                                              CarbonCalculator
                                                  .parseNetworkDownload(
                                                      netUsage!)))
                                      : "0",
                                  style: TextStyle(
                                    color: Color(0xFF07684B),
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'GB',
                                  style: TextStyle(
                                    color: Color(0xFF07684B),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 14 / 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 197 * widthRadio,
                            top: 131,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  netUsage != null
                                      ? CarbonCalculator.formatCO2Output(
                                          CarbonCalculator.convertStorageToGB(
                                              CarbonCalculator
                                                  .parseNetworkUpload(
                                                      netUsage!)))
                                      : "0",
                                  style: const TextStyle(
                                    color: Color(0xFF07684B),
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'GB',
                                  style: TextStyle(
                                    color: Color(0xFF07684B),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 14 / 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        Positioned(
                            right: 21,
                            top: 133,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => DashBoardPage(
                                            appNetworkUsage: appNetworkUsage!,
                                            storageUsage: storageUsage!,
                                            netUsage: netUsage!,
                                          )),
                                );
                              },
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
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 169,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CarouselCard(
                              image: 'assets/homepage/car.png',
                              details:
                                  'It is estimated a small car’s carbon emission.',
                              number: CarbonCalculator.formatCO2Output(
                                  (cloudData ? storageCO2 : netCO2) /
                                      1000 *
                                      4.59),
                              unit: 'Km'),
                          SizedBox(
                            width: 12,
                          ),
                          CarouselCard(
                              image: 'assets/homepage/food.png',
                              details:
                                  'It is estimated eqaul to one meal with beef.',
                              number: CarbonCalculator.formatCO2Output(
                                  (cloudData ? storageCO2 : netCO2) /
                                      1000 *
                                      0.14),
                              unit: 'Kg / beef'),
                          SizedBox(
                            width: 12,
                          ),
                          CarouselCard(
                              image: 'assets/homepage/water.png',
                              details:
                                  'It is estimated produce every bottled water.',
                              number: CarbonCalculator.formatCO2Output(
                                  (cloudData ? storageCO2 : netCO2) /
                                      1000 *
                                      3.75),
                              unit: 'Liter'),
                          SizedBox(
                            width: 12,
                          ),
                          CarouselCard(
                              image: 'assets/homepage/video.png',
                              details:
                                  'It is estimated eqaul to hours of video stream.',
                              number: CarbonCalculator.formatCO2Output(
                                  (cloudData ? storageCO2 : netCO2) /
                                      1000 *
                                      4.52),
                              unit: 'Hours'),
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
                        Dashline(),
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
          if (offset > 10)
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
