import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: 'courtfinder',
    home: new HomeScreen(),
  ));
}

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
                image: new DecorationImage(image: new AssetImage("assets/court.png"), fit: BoxFit.cover,),
              ),
            ),
            new Center(
              child: new RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new LocationScreen()),
                  );
                },
                child: new Text('Find courts near you.'),
              ),
            )
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
            'assets/newyork.jpg',
            height: 240.0,
            fit: BoxFit.cover,
          ),
          new Image.asset(
            'assets/losangeles.jpg',
            height: 240.0,
            fit: BoxFit.cover,
          ),
          new Image.asset(
            'assets/chicago.jpg',
            height: 240.0,
            fit: BoxFit.cover,
          ),                    
        ],
      )
    );
  }
}