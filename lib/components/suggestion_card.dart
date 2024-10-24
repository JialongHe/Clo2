import 'package:clo2/pages/application_page.dart';
import 'package:clo2/pages/information_page.dart';
import 'package:flutter/material.dart';

class SuggestionCard extends StatelessWidget {
  final String image; // Image string
  final String name; // Details string
  final String detail; // Number string
  Widget? linkPage; // Unit string

  SuggestionCard({
    required this.image,
    required this.name,
    required this.detail,
    this.linkPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  linkPage != null ? linkPage! : Container()));
        },
        child: Container(
            height: 64,
            child: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.name,
                      style: const TextStyle(
                          color: Color(0xFF07684B),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 20 / 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      this.detail,
                      style: const TextStyle(
                        color: Color(0xFF8A8B87),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 16 / 12,
                      ),
                    ),
                  ],
                )),
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/homepage/arrow_circle_right.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )));
  }
}
