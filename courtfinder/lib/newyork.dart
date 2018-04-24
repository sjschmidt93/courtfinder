import 'package:flutter/material.dart';
import 'utils.dart';

class NewYorkScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
      children: [
        Utils.getLocation(context, 'images/manhattan.jpg', 'Manhattan'),
        Utils.getLocation(context, 'images/brooklyn.jpg', 'Brooklyn'),
        Utils.getLocation(context, 'images/statenisland.jpg', 'Staten Island'),
        Utils.getLocation(context, 'images/bronx.jpg', 'The Bronx'),
        Utils.getLocation(context, 'images/queens.jpg', 'Queens'),
      ],
    ));
  }
}
