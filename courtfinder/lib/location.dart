import 'package:flutter/material.dart';

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