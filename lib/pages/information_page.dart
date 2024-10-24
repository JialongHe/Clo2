import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  final String name;
  final String tab1Name;
  final String tab2Name;
  Widget? content1;
  Widget? content2;

  InformationPage(
      {required this.name,
      required this.tab1Name,
      required this.tab2Name,
      this.content1,
      this.content2});

  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage> {
  int selectedIndex = 0;

  static TextStyle activateText = const TextStyle(
    color: Color(0xFF07684B),
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    height: 24 / 16,
  );

  static TextStyle inActivateText = const TextStyle(
    color: Color(0xFF8A8B87),
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 144,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 28,
                  margin: EdgeInsets.fromLTRB(18, 62, 0, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/information/keyboard_arrow_left.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(
                          color: Color(0xFF072100),
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 28 / 18,
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 18,
              ),
              Container(
                height: 36,
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          this.setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: Container(
                          width: 128,
                          height: 36,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  widget.tab1Name,
                                  textAlign: TextAlign.center,
                                  style: this.selectedIndex == 0
                                      ? activateText
                                      : inActivateText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (this.selectedIndex == 0)
                                Container(
                                  width: 120,
                                  height: 4,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF07684B),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                  ),
                                ),
                            ],
                          ),
                        )),
                    SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                        onTap: () {
                          this.setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: Container(
                      width: 128,
                      height: 36,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              widget.tab2Name,
                              textAlign: TextAlign.center,
                              style: this.selectedIndex == 1
                                  ? activateText
                                  : inActivateText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (this.selectedIndex == 1)
                            Container(
                              width: 120,
                              height: 4,
                              decoration: ShapeDecoration(
                                color: Color(0xFF07684B),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                            )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
                margin: const EdgeInsets.all(18),
                child: SingleChildScrollView(
                  child: selectedIndex == 0 ? widget.content1 : widget.content2,
                )))
      ],
    );
  }
}
