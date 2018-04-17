import 'package:flutter/material.dart';
import 'login.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: [
          new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new LoginScreen()),
              );
            },
            child: new Stack(
              children: <Widget>[
                new Image.asset(
                  'images/newyork.jpg',
                  height: 240.0,
                  fit: BoxFit.cover
                ),
                new Text('NEW YORK',
                  style: new TextStyle(
                    fontSize: 48.0,
                    color: new Color(0xFFFFFFFF),
                  )
                )
              ],
            ),
          ),
          new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new LoginScreen()),
              );
            },
            child: new Stack(
              children: <Widget>[
                new Image.asset(
                  'images/losangeles.jpg',
                  height: 240.0,
                  fit: BoxFit.fitWidth
                ),
                new Text('LOS ANGELES',
                  style: new TextStyle(
                    fontSize: 48.0,
                    color: new Color(0xFFFFFFFF),
                  )
                )
              ],
            ),
          ),
          new Container (
            height: 255.0,
            child: new GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new LoginScreen()),
                );
              },
              child: new Container (
                height: 240.0,
                child: new Stack(
                  children: <Widget>[
                    new Image.asset(
                        'images/chicago.jpg',
                        fit: BoxFit.cover 
                    ),
                    new Text('CHICAGO',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 48.0,
                        color: new Color(0xFFFFFFFF),
                      )
                    )
                  ],
                ),
              )
            ),    
          )            
        ],
      )
    );
  }
}