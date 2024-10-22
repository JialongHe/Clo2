import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  final String image; // Image string
  final String details; // Details string
  final String number; // Number string
  final String unit; // Unit string

  CarouselCard({
    required this.image,
    required this.details,
    required this.number,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146,
      height: 122,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            height: 28,
            child: Row(
              children: [
                Text(
                  number,
                  style: const TextStyle(
                    color: Color(0xFF07684B),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: const TextStyle(
                    color: Color(0xFF07684B),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 146,
            height: 46,
            child: Text(
              details,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF8A8B87),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
