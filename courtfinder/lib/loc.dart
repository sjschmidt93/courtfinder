import 'package:flutter/material.dart';
import 'utils.dart';

class LocationScreen extends StatelessWidget {
  final String userToken;

  const LocationScreen({Key key, this.userToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
      children: [
        Utils.getLocation(context, 'images/chicago.jpg', 'Chicago', userToken),
        Utils.getLocation(context, 'images/newyork.jpg', 'New York', userToken),
        Utils.getLocation(
            context, 'images/losangeles.jpg', 'Los Angeles', userToken)
      ],
    ));
  }
}
