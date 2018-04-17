import 'package:flutter/material.dart';
import 'court.dart';

class LocationScreen extends StatelessWidget {

  _getLocation(BuildContext context, String imageName, String locationName) { 
    return 
      new Container(
          height: 255.0,
          child: new GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new CourtScreen(locationName, 3)),
                );
              },
              child: new Container(
                height: 240.0,
                child: new Stack(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new AssetImage(imageName),
                        )
                      )
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text(locationName,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 48.0,
                              color: new Color(0xFFFFFFFF),
                            ))
                      ],
                    )
                  ],
                ),
              )
            )
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
      children: [
        _getLocation(context, 'images/chicago.jpg', 'Chicago'),
        _getLocation(context, 'images/newyork.jpg', 'New York'),
        _getLocation(context, 'images/losangeles.jpg', 'Los Angeles')
      ],
    ));
  }
}
