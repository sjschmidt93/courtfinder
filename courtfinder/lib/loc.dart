import 'package:flutter/material.dart';
import 'utils.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
      children: [
        Utils.getLocation(context, 'images/chicago.jpg', 'Chicago'),
        Utils.getLocation(context, 'images/newyork.jpg', 'New York'),
        Utils.getLocation(context, 'images/losangeles.jpg', 'Los Angeles')
      ],
    ));
  }
}