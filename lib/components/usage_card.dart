import 'package:flutter/material.dart';

class UsageCard extends StatelessWidget {
  final String usage;
  final String name;
  final double percent;
  final bool bold;

  UsageCard(
      {required this.usage,
      required this.name,
      required this.percent,
      required this.bold});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.name,
            style: const TextStyle(
              color: Color(0xFF072100),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 20 / 14,
            ),
          ),
          SizedBox(
            height: 24,
            child: Row(
              children: [
                Container(
                  height: 12,
                  width: (screenWidth - 148) * percent,
                  decoration: ShapeDecoration(
                    color: bold ? Color(0xFF07684B) : Color(0xFFD9E7CA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  this.usage,
                  style: const TextStyle(
                    color: Color(0xFF8A8B87),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'g',
                  style: TextStyle(
                    color: Color(0xFF8A8B87),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 24 / 12,
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
