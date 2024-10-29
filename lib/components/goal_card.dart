import 'package:clo2/themes/app_theme.dart';
import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final String leftImage;
  final String name;
  final int progess;
  final int capacity;
  final String rightImage;

  GoalCard(
      {required this.leftImage,
      required this.name,
      required this.capacity,
      required this.progess,
      required this.rightImage});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double widthRadio = screenWidth / AppTheme.designWidth;
    double heightRadio = screenHeight / AppTheme.designHeigh;
    
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: ShapeDecoration(
        color: Color(0xFFEDF6E9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(this.leftImage),
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(
            width: 8,
          ),
          SizedBox(
              width: 208 * widthRadio,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.name,
                    style: TextStyle(
                      color: Color(0xFF072100),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 20 / 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: 208 * widthRadio,
                    height: 12,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 208 * widthRadio,
                            height: 12,
                            decoration: ShapeDecoration(
                              color: Color(0xFFD9E7CA),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 208 * widthRadio * this.progess / this.capacity,
                            height: 12,
                            decoration: ShapeDecoration(
                              color: Color(0xFF07684B),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 88 * widthRadio,
                          top: 1,
                          child: Text(
                            '${this.progess} / ${this.capacity}',
                            style: TextStyle(
                              color: this.progess < this.capacity ? Color(0xFF072100) : Colors.white,
                              fontSize: 10,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Spacer(),
          Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(this.rightImage),
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }
}
