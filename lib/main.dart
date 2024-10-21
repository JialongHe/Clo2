import 'dart:ui';

import 'package:clo2/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(Clo2App());
}

class Clo2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
        
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

class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundColor,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
        ),
        child: HomePage(),
      ),
    );
  }
}
