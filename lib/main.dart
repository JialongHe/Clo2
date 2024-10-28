import 'dart:ui';

import 'package:clo2/pages/login_page.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:clo2/utils/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

import 'package:clo2/components/drawer.dart' as D;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: Clo2App()));
}

class Clo2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final FlutterView view =
            WidgetsBinding.instance.platformDispatcher.views.first;

        return Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQueryData.fromView(view),
            child: AppContainer(),
          ),
        );
      },
    );
  }
}

class AppContainer extends StatefulWidget {
  @override
  AppContainerState createState() => AppContainerState();
}

class AppContainerState extends State<AppContainer> {
  bool drawerVisible = false;
  toggleDrawer() {
    this.setState(() {
      drawerVisible = !drawerVisible;
    });
  }

  Widget? drawerContent;

  ScrollBehavior customScrollBehavior = const ScrollBehavior().copyWith(
    scrollbars: false,
  );

  updateDrawer(Widget? newContent) {
    this.setState(() {
      this.drawerContent = newContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: AppTheme.backgroundColor,
      child: DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
          ),
          child: ScrollConfiguration(
            behavior: customScrollBehavior,
            child: Stack(
              children: [
                SafeArea(
                  top: true,
                  child: Navigator(
                    pages: [
                      MaterialPage(child: LoginPage()
                          // HomePage()
                          ),
                    ],
                    onPopPage: (route, result) {
                      if (!route.didPop(result)) {
                        return false;
                      }
                      return true;
                    },
                  ),
                ),
                if (this.drawerVisible)
                  Container(
                    width: screenWidth,
                    height: screenHeight,
                    decoration: BoxDecoration(color: Color(0x7F383838)),
                  ),
                D.Drawer(
                  isDrawerVisible: this.drawerVisible,
                  child: this.drawerContent,
                ),
              ],
            ),
          )),
    );
  }
}
