import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWithGoogle {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void googleSignInServices() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // ignore: deprecated_member_use
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      // ignore: deprecated_member_use
      final User user =   (await firebaseAuth.signInWithCredential(credential)).user;

      print(user.displayName);
    } 

    catch (e) {
      print(e.toString());
    }

  }
}
