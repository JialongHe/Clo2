import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String name;
  final String content;

  InformationCard({required this.name, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            this.name,
            style: TextStyle(
              color: Color(0xFF072100),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 24 / 16,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            width: 340,
            child: Text(
              this.content,
              style: TextStyle(
                color: Color(0xFF8A8B87),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 20 / 14,
              ),
              softWrap: true,
            ),
          )
        ]));
  }
}
