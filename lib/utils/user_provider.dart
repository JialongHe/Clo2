import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  GoogleSignInAccount? _googleAccount;

  User? get user => _user;
  GoogleSignInAccount? get googleAccount => _googleAccount;

  void login(User user, GoogleSignInAccount googleAccount) {
    _user = user;
    _googleAccount = googleAccount;
    notifyListeners();
  }

  Future<String?> getAccessToken() async {
    if (_googleAccount != null) {
      final googleAuth = await _googleAccount!.authentication;
      return googleAuth.accessToken;
    }
    return null;
  }

  void logout() {
    _user = null;
    _googleAccount = null;
    notifyListeners();
  }
}
