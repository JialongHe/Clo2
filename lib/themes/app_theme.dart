import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  // Sizes for Responsive
  static const double designHeigh = 892;
  static const double designWidth = 412;

  // Colors
  static const Color backgroundColor = Color.fromRGBO(244, 244, 244, 1);

  // Font styles
  static const String defaultFontFamiliy = 'Roboto';

  static const roboto14RegularWhite = TextStyle(
                              color: Color(0xFFEDF6E9),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                          );

  static const roboto14BoldGreen = TextStyle(
                              color: Color(0xFF07684B),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                          );                        

  static const roboto28BoldGreen = TextStyle(
                        color: Color(0xFF07684B),
                        fontSize: 28,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                    );

  // Layout style
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 18.0);
  
}
