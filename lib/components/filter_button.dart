import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  bool isActive;

  FilterButton({required this.label, required this.onTap, this.isActive = false});

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isActive = false;

  // TODO-2: possible upgrade
  // void toggleActiveState() {
  //   setState(() {
  //     isActive = !isActive;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // toggleActiveState();
        widget.onTap();
      },
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: ShapeDecoration(
          color: widget.isActive ? Color(0xFFD9E7CA) : Color(0xFFE7E7E7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: widget.isActive ? Color(0xFF072100) : Color(0xFF8A8B87),
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
