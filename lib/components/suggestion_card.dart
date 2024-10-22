import 'package:flutter/material.dart';

class SuggestionCard extends StatelessWidget {
  final String image; // Image string
  final String name; // Details string
  final String detail; // Number string
  String? link; // Unit string

  SuggestionCard({
    required this.image,
    required this.name,
    required this.detail,
    this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12,),
                      SizedBox(
                        height: 20,
                        child: Text(
                          this.name,
                          style: const TextStyle(
                            color: Color(0xFF07684B),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                        child: Text(
                          this.detail,
                          style: const TextStyle(
                            color: Color(0xFF8A8B87),
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0.11,
                          ),
                        ),
                      )
                    ],
                  )
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/homepage/arrow_circle_right.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ));
  }
}
