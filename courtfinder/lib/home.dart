import 'package:courtfinder/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'court.dart';
import 'login.dart';
import 'loc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
  
}

class HomeScreenState extends State<HomeScreen> {
  String userToken;
  String userEmail;
  String userName;

  void loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userToken = prefs.get("firebaseToken");
      userEmail = prefs.get("firebaseEmail");
      userName = prefs.get("firebaseName");
      print(userToken);
    });
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("firebaseToken");
    await prefs.remove("firebaseEmail");
    await prefs.remove("firebaseName");
    print("Logging out");
    setState(() {
      userToken = null;
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
          title: new Text('courtfinder'),
          backgroundColor: Colors.black
        ),
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("images/court.png"), fit: BoxFit.cover,),
              ),
            ),
            new Column (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text("Hello $userName"),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new LocationScreen()),
                          );
                        },
                        child: new Text('Pick your location'),
                      ),  
                      new RaisedButton(
                        onPressed: () {
                          ApiFunctions.getAllCourts().then((courts) {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(builder: (context) => new CourtScreen('New York', 3)),
                            );
                          });
                        },
                        child: new Text('Find courts'),
                      )
                    ]
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new LoginScreen(userToken != null)),
                          );
                        },
                        child: new Text('Login'),
                      ),  
                      new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new SettingsScreen()),
                          );
                        },
                        child: new Text('Settings'),
                      ),
                      new RaisedButton(onPressed: () => logout(), child: new Text("Logout"),)
                    ]
                  )
                ]
              ),

          ],
        )
      ),
    );
  }
}