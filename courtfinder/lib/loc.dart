import 'package:flutter/material.dart';
import 'utils.dart';

class LocationScreen extends StatelessWidget {
  final String userUid;

  const LocationScreen({Key key, this.userUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
      children: [
        Utils.getLocation(context, 'images/chicago.jpg', 'Chicago', userUid),
        Utils.getLocation(context, 'images/newyork.jpg', 'New York', userUid),
        Utils.getLocation(
            context, 'images/losangeles.jpg', 'Los Angeles', userUid)
      ],
    ));
  }
}
