import 'package:araplantas_mobile/data/user_api.dart';
import 'package:araplantas_mobile/models/user.dart' as user_model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;

      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential creds =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future logout() async {
    try {
      await googleSignIn.disconnect();
    } catch (e) {
      print(e.toString());
    } finally {
      FirebaseAuth.instance.signOut();
    }
  }
}
