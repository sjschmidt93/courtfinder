import 'package:flutter/material.dart';
import 'utils.dart';

class NewYorkScreen extends StatelessWidget {
  final String userToken;

  const NewYorkScreen({Key key, this.userToken}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
      children: [
        Utils.getLocation(context, 'images/manhattan.jpg', 'Manhattan', userToken),
        Utils.getLocation(context, 'images/brooklyn.jpg', 'Brooklyn', userToken),
        Utils.getLocation(context, 'images/statenisland.jpg', 'Staten Island', userToken),
        Utils.getLocation(context, 'images/bronx.jpg', 'The Bronx', userToken),
        Utils.getLocation(context, 'images/queens.jpg', 'Queens', userToken),
      ],
    ));
  }
}
