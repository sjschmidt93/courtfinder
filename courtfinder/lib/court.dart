import 'package:flutter/material.dart';
import 'filter.dart';

class Court {
  String imageName;
  String courtName;
  bool courtType; // 1 = full-court, 0 = half-court
  double distance;
  Court(this.imageName, this.courtName, this.courtType, this.distance) ;
}

class CourtScreen extends StatelessWidget {

  String location;
  int results;
  bool colorFlag = true;

  // returns the display for a court with all the associated information
  // this funtion will be called after a request to firebase server is completed
  // and all the returned data is parsed into Court objects
  _getCourtDisplay(Court court) { 
    colorFlag = !colorFlag;
    return new Container(
      decoration: new BoxDecoration(
        color: colorFlag ? Colors.blue[300] : Colors.red[300],
        borderRadius: new BorderRadius.all(
          const Radius.circular(8.0),
        ), 
      ),
      padding: new EdgeInsets.all(20.0),
      child: new Row(
        children: [ 
          new Expanded( 
            child: new Image.asset(court.imageName), 
          ),
          new Expanded( 
            child: new Column(
              children: [
                new ListTile(
                  leading: new Icon(Icons.map),
                  title: new Text(court.courtName),
                ),
                new ListTile(
                  leading: new Icon(Icons.place),
                  title: new Text(court.distance.toString() + ' miles away'),
                ),
                new ListTile(
                  leading: new Icon(Icons.panorama_fish_eye),
                  title: new Text(court.courtType ? 'Full-court' : 'Half-court'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  CourtScreen(String location, int results) { 
    this.location = location;
    this.results = results;
  }

  @override
  Widget build(BuildContext context) { 
    return new Scaffold(
      body: new ListView(
        children: [ 
          new Text(
            this.results.toString() + " courts found in " + this.location + "\n",
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: 'Helvetica', 
              fontWeight: FontWeight.bold)
            ),
          new RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new FilterScreen()),
              );
            },
            child: new Text('Filter courts'),
          ),            
          _getCourtDisplay(new Court('images/ruckerpark.jpg', 'Rucker Park', true, 0.8)),
          _getCourtDisplay(new Court('images/venicebeach.jpg', 'Venice Beach', true, 2108.9)),
          _getCourtDisplay(new Court('images/lincolnpark.jpg', 'Lincoln Park', true, 1037.1))
        ]
      )
    );
  }
}