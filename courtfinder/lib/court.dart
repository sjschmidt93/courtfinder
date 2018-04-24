import 'package:courtfinder/api.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'filter.dart';
import 'dart:math';

class Court {
  String imageName;
  String courtName;
  bool courtType; // 1 = full-court, 0 = half-court
  double distance;
  Court(this.imageName, this.courtName, this.courtType, this.distance);
}

class CourtScreen extends StatefulWidget {
  final _location;
  final _results;

  CourtScreen(this._location, this._results);

  @override
  State<StatefulWidget> createState() =>
      new CourtScreenState(_location, _results);
}

class CourtScreenState extends State<CourtScreen> {
  String location;
  int results;
  bool colorFlag = true;

  List<Widget> courtDisplayList = [];

  /// Calculate the Haversine Distance Formula
  num _calculateDistance(num lon1, num lat1, num lon2, num lat2) {
    lon1 = lon1 * pi / 180;
    lat1 = lat1 * pi / 180;
    lon2 = lon2 * pi / 180;
    lat2 = lat2 * pi / 180;

    num dlon = lon2 - lon1;
    num dlat = lat2 - lon2;

    num a = pow(sin(dlat/2),2) + cos(lat1) * cos(lat2) * pow(sin(dlon/2), 2);
    num c = 2 * asin(sqrt(a));
    num r = 3959; // Radius of Earth in miles :)
    return c * r;
  }

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
                  title: new Text((court.distance/1000.0).toStringAsFixed(2) + ' miles away'),
                ),
                new ListTile(
                  leading: new Icon(Icons.panorama_fish_eye),
                  title:
                      new Text(court.courtType ? 'Full-court' : 'Half-court'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildCourtList(List courts, Map<String, double> currentLocation) {
    num curLat = currentLocation["latitude"];
    num curLon = currentLocation["longitude"];

    List<Widget> displayList = [
      new Text(
          this.results.toString() + " courts found" + " near you." + "\n",
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontFamily: 'Helvetica', fontWeight: FontWeight.bold)),
      new RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new FilterScreen()),
          );
        },
        child: new Text('Filter courts'),
      ),
    ];

    Iterable<Widget> courtDisplays = courts.map((courtData) {
      num courtLat = courtData["latitude"];
      num courtLon = courtData["longitude"];
      double distance = _calculateDistance(curLon, curLat, courtLon, courtLat);
      return _getCourtDisplay(
          new Court('images/ruckerpark.jpg', courtData['name'], true, distance));
    });
    displayList.addAll(courtDisplays);
    return displayList;
  }

  CourtScreenState(String location, int results) {
    this.location = location;
    this.results = results;
  }

  @override
  void initState() {
    var userLocation = new Location();
    ApiFunctions.getAllCourts().then((courts) {
      userLocation.getLocation.then((currentLocation) {
        setState(() {
          courtDisplayList = _buildCourtList(courts, currentLocation);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(children: courtDisplayList));
  }
}
