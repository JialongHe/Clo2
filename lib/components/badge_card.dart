import 'package:flutter/material.dart';

class BadgeCard extends StatelessWidget {
  final String image;
  final String name;

  BadgeCard({
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 89,
      height: 124,
      child: Column(
        children: [
          Container(
            width: 89,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 20,
            child: Text(
              name,
              style: const TextStyle(
                color: Color(0xFF07684B),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 20 / 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
