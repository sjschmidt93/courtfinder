import 'package:flutter/material.dart';
import 'home.dart';
import 'main.dart';

class CourtScreen extends StatelessWidget {

  // returns the display for a court with all the associated information, hardcoded to rucker park for now
  _getCourtDisplay() { 
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.blue[300],
        borderRadius: new BorderRadius.all(
          const Radius.circular(8.0),
        ), 
      ),
      padding: new EdgeInsets.all(20.0),
      child: new Row(
        children: [ 
          new Expanded( 
            child: new Image.asset('images/ruckerpark.jpg'), 
          ),
          new Expanded( 
            child: new Column(
              children: [
                new ListTile(
                  leading: new Icon(Icons.map),
                  title: new Text('Rucker Park'),
                ),
                new ListTile(
                  leading: new Icon(Icons.place),
                  title: new Text('0.8 miles away'),
                ),
                new ListTile(
                  leading: new Icon(Icons.panorama_fish_eye),
                  title: new Text('Full-court'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) { 
    return new Scaffold(
      body: new ListView(
        children: [ 
          new Text(
            "Courts near you \n",
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: 'Helvetica', 
              fontWeight: FontWeight.bold)
            ),
          _getCourtDisplay(),
        ]
      )
    );
  }
}

