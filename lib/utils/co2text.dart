import 'package:flutter/material.dart';

class Co2text extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    width: 38,
    height: 16,
    child: Stack(
        children: [
            const Positioned(
                left: 0,
                top: 0,
                child: Text(
                    'g',
                    style: TextStyle(
                        color: Color(0xFF07684B),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                    ),
                ),
            ),
            Positioned(
                left: 10,
                top: 0,
                child: Container(
                    width: 28,
                    height: 16,
                    child: const Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Text(
                                    'CO',
                                    style: TextStyle(
                                        color: Color(0xFF07684B),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 21,
                                top: 0,
                                child: Text(
                                    'e',
                                    style: TextStyle(
                                        color: Color(0xFF07684B),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 16,
                                top: 7,
                                child: Text(
                                    '2',
                                    style: TextStyle(
                                        color: Color(0xFF07684B),
                                        fontSize: 8,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ],
    ),
  );
  }
}