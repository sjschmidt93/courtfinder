import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

// firebase authentication source: https://pub.dartlang.org/packages/firebase_auth

class LoginScreen extends StatelessWidget { 

    GoogleSignIn _googleSignIn = new GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    Future<Null> _handleSignIn() async {
      try {
        await _googleSignIn.signIn();
      } catch (error) {
        print(error);
      }
    }

  @override
  Widget build(BuildContext context) { 
    
    final googleSignIn = new GoogleSignIn();  

    return new Scaffold(
      body: new Center(
        child: new RaisedButton(
          onPressed: _handleSignIn,
          child: new Text('Sign in with Google'),
        ),  
      )
    );
  }

}