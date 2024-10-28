import 'package:clo2/pages/home_page.dart';
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
      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 132,
        ),
        Container(
          width: 320,
          height: 380,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/landing/landing_illustration.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 170,
          height: 52,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/landing/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 77,
        ),
        GestureDetector(
          onTap: () async {
            User? user = await _signInWithGoogle();
            if (user != null) {
              // print("User signed in: ${user.displayName}");
              context.read<UserProvider>().login(user);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          },
          child: Container(
              width: 372,
              height: 60,
              padding: const EdgeInsets.only(
                top: 16,
                left: 71,
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
                    const SizedBox(width: 27),
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
    );
  }
}
