import 'package:clo2/pages/home_page.dart';
import 'package:clo2/themes/app_theme.dart';
import 'package:clo2/utils/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '366573246764-tfmt485aim37bm566igjf1qa8ks5pb9e.apps.googleusercontent.com',
    scopes: [
      'https://www.googleapis.com/auth/drive.metadata.readonly',
      'https://www.googleapis.com/auth/gmail.readonly',
      'https://www.googleapis.com/auth/calendar.readonly',
    ],
  );

  Future<User?> _signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the Google token
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using the credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      context.read<UserProvider>().login(user!, googleUser);

      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double widthRadio = screenWidth / AppTheme.designWidth;
    double heightRadio = screenHeight / AppTheme.designHeigh;

    return Container(
      width: screenWidth,
      height: screenHeight,
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 132 * heightRadio,
          ),
          Container(
            width: 320 * widthRadio,
            height: 380 * widthRadio,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/landing/landing_illustration.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20 * heightRadio,
          ),
          Container(
            width: 170 * widthRadio,
            height: 52 * widthRadio,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/landing/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 77 * heightRadio,
          ),
          GestureDetector(
            onTap: () async {
              User? user = await _signInWithGoogle();

              if (user != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            },
            child: Container(
                width: 372 * widthRadio,
                height: 60,
                padding: EdgeInsets.only(
                  top: 16,
                  left: 71 * widthRadio,
                  bottom: 16,
                ),
                decoration: ShapeDecoration(
                  color: Color(0xFF07684B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Container(
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/landing/google.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 27 * widthRadio),
                      const Text(
                        'Log in with Google',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 28 / 18,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          const SizedBox(
            height: 26,
          ),
          const Text(
            'Continue without log in',
            style: TextStyle(
              color: Color(0xFF8A8B87),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              height: 20 / 14,
            ),
          )
        ],
      )),
    );
  }
}
