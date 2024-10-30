import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  String? image;
  final String name;
  final String bandWith;

  DataCard({this.image, required this.name, required this.bandWith});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (image != null) ...[
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image!), // TODO: where do we get the image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            )
          ],
          Text(
            this.name,
            style: const TextStyle(
              color: Color(0xFF072100),
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 28 / 18,
            ),
          ),
          Spacer(),
          Container(
            width: 80,
            height: 48,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Text(
                        this.bandWith,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF07684B),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
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
                        '200',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF07684B),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'MB',
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
