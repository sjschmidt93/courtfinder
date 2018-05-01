import 'dart:async';

import 'package:courtfinder/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'court.dart';
import 'loc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  String useruid;
  String userEmail;
  String userName;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextStyle infoStyle = new TextStyle(
    fontSize: 24.0,
    color: Colors.black,
  );

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
      String uid = user.uid;
      String email = user.email;
      String name = user.displayName;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("firebaseUid", uid);
      await prefs.setString("firebaseEmail", email);
      await prefs.setString("firebaseName", name);

      print("Login Successful: $uid");
      setState(() {
        useruid = uid;
        userEmail = email;
        userName = name;
      });
    } catch (error) {
      print(error);
    }
  }

  void loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      useruid = prefs.get("firebaseUid");
      userEmail = prefs.get("firebaseEmail");
      userName = prefs.get("firebaseName");
    });
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _googleSignIn.signOut();
    await prefs.remove("firebaseUid");
    await prefs.remove("firebaseEmail");
    await prefs.remove("firebaseName");
    print("Logging out");
    setState(() {
      useruid = null;
      userName = null;
      userEmail = null;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'courtfinder',
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('CourtFinder'),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          body: new Stack(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("images/court.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          padding: new EdgeInsets.all(10.0),
                          decoration: new BoxDecoration(
                              color: new Color.fromRGBO(255, 255, 255, 0.5)),
                          child: (userName != null)
                              ? new Text(
                                  "Hello $userName",
                                  style: infoStyle,
                                )
                              : new Text(
                                  "Not Logged In",
                                  style: infoStyle,
                                ),
                        )
                      ],
                    ),
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new LocationScreen(
                                          userUid: useruid,
                                        )),
                              );
                            },
                            child: new Text('Pick your location'),
                          ),
                          new RaisedButton(
                            onPressed: () {
                              ApiFunctions.getAllCourts().then((courts) {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new CourtScreen(
                                          'New York', 3, useruid)),
                                );
                              });
                            },
                            child: new Text('Find courts'),
                          )
                        ]),
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new RaisedButton(
                            onPressed: () => _handleSignIn(context),
                            child: new Text('Login'),
                          ),
                          new RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new SettingsScreen()),
                              );
                            },
                            child: new Text('Settings'),
                          ),
                          new RaisedButton(
                            onPressed: () => logout(),
                            child: new Text("Logout"),
                          )
                        ])
                  ]),
            ],
          )),
    );
  }
}
