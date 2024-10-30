import 'package:clo2/pages/game_page.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:clo2/utils/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double widthRadio = screenWidth / AppTheme.designWidth;
    double heightRadio = screenHeight / AppTheme.designHeigh;
    
    User? user = context.watch<UserProvider>().user;

    return Column(
      children: [
        // Status bar height
        // Todo, makes sure works cross platform
        const SizedBox(height: 56),
        Container(
            padding: AppTheme.horizontalPadding,
            width: double.infinity,
            height: 290,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: user != null ? NetworkImage(user.photoURL!) : const AssetImage('assets/homepage/avatar.png'),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 154,
                      height: 36,
                      margin: const EdgeInsets.only(top: 25),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/homepage/logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 169,
                      height: 20,
                      margin: const EdgeInsets.only(top: 15),
                      child: const Text(
                        'Track Cloud Usage &',
                        style: TextStyle(
                          color: Color(0xFF8A8B87),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: 169,
                      height: 20,
                      margin: const EdgeInsets.only(top: 3),
                      child: const Text(
                        'Carbon Footprint',
                        style: TextStyle(
                          color: Color(0xFF8A8B87),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => GamePage()),
                        )
                      },
                      child: Container(
                        width: 376 * widthRadio,
                        height: 99,
                        margin: const EdgeInsets.only(top: 17),
                        child: Stack(
                          children: [
                            Container(
                              width: 376 * widthRadio,
                              height: 99,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/homepage/status_background.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 23,
                                    margin: const EdgeInsets.only(top: 15),
                                    child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('Lv. 1 ',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w600,
                                              )),
                                          SizedBox(width: 12),
                                          Text(
                                            'My Tree',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ]),
                                  ),
                                  Container(
                                    height: 16,
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            '300 Credits to Level Up',
                                            style: TextStyle(
                                              color: Color(0xFFD9E7CA),
                                              fontSize: 12,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Container(
                                            width: 16,
                                            height: 16,
                                            margin:
                                                const EdgeInsets.only(left: 4),
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/homepage/keyboard_arrow_right.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    width: 180 * widthRadio,
                                    height: 6,
                                    margin: const EdgeInsets.only(top: 7),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 180 * widthRadio,
                                            height: 6,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFEDF6E9),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 106.17,
                                            height: 6,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFE970F),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                            ),
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
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  right: 11,
                  child: Container(
                    width: 166 * widthRadio,
                    height: 251 * widthRadio,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/homepage/tree_model.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
