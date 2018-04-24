import 'package:courtfinder/api.dart';
import 'package:flutter/material.dart';
import 'settings.dart';
import 'court.dart';
import 'login.dart';
import 'loc.dart';

class HomeScreen extends StatelessWidget {
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
                children: [
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
                            new MaterialPageRoute(builder: (context) => new LoginScreen()),
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