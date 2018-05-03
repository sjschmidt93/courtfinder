import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

// firebase authentication source: https://pub.dartlang.org/packages/firebase_auth

class LoginScreen extends StatelessWidget {
  final bool _tokenExists;

  LoginScreen(this._tokenExists);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<Null> _handleSignIn(context) async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      FirebaseUser user = await _auth.signInWithGoogle(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      String userToken = await user.getIdToken();
      String userEmail = user.email;
      String userName = user.displayName;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("firebaseToken", userToken);
      await prefs.setString("firebaseEmail", userEmail);
      await prefs.setString("firebaseName", userName);
      Navigator.pop(context);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
      child: _tokenExists
          ? new Text("Already Logged In")
          : new RaisedButton(
              onPressed: () => _handleSignIn(context),
              child: new Text('Sign in with Google'),
            ),
    ));
  }
}
