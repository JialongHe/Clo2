import 'package:clo2/utils/carbon_calculator.dart';
import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  String? image;
  final String name;
  final double bandWidth;

  DataCard({this.image, required this.name, required this.bandWidth});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // if (image != null)
          ...[
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/dashboard/app.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            )
          ],
          Expanded(
            child: Text(
              this.name,
              style: const TextStyle(
                  color: Color(0xFF072100),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 28 / 16,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 80,
            height: 48,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Text(
                        CarbonCalculator.formatCO2Output(
                            CarbonCalculator.convertGbToCO2(bandWidth)),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color(0xFF07684B),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'g',
                        style: TextStyle(
                          color: Color(0xFF8A8B87),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 16 / 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 24,
                  child: Row(
                    children: [
                      Text(
                        CarbonCalculator.formatCO2Output(bandWidth),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color(0xFF07684B),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'GB',
                        style: TextStyle(
                          color: Color(0xFF8A8B87),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 16 / 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
