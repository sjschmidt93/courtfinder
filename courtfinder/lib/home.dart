import 'package:flutter/material.dart';
import 'settings.dart';
import 'court.dart';
import 'login.dart';

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
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new CourtScreen()),
                          );
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

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: [
          new Image.asset(
            'images/newyork.jpg',
            height: 240.0,
            fit: BoxFit.cover,
          ),
          new Image.asset(
            'images/losangeles.jpg',
            height: 240.0,
            fit: BoxFit.cover,
          ),
          new Image.asset(
            'images/chicago.jpg',
            height: 240.0,
            fit: BoxFit.cover,
          ),                    
        ],
      )
    );
  }
}