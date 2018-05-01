import 'package:courtfinder/api.dart';
import 'package:courtfinder/court_info.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'filter.dart';
import 'dart:math';

class Court {
  String imageName;
  String courtName;
  bool courtType; // 1 = full-court, 0 = half-court
  double distance;
  num latitude;
  num longitude;
  String id;
  Court(this.imageName, this.courtName, this.courtType, this.distance,
      this.latitude, this.longitude, this.id);
}

class CourtScreen extends StatefulWidget {
  final String _userUid;
  final _location;
  int _results;

  CourtScreen(this._location, this._results, this._userUid);

  @override
  State<StatefulWidget> createState() =>
      new CourtScreenState(_location, _userUid);
}

class CourtScreenState extends State<CourtScreen> {
  final String _userUid;
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

    num a =
        pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
    num c = 2 * asin(sqrt(a));
    num r = 3959; // Radius of Earth in miles :)
    return c * r;
  }

  // returns the display for a court with all the associated information
  // this funtion will be called after a request to firebase server is completed
  // and all the returned data is parsed into Court objects
  _getCourtDisplay(Court court) {
    colorFlag = !colorFlag;
    return new GestureDetector(
        onTap: () => Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new CourtInfo(
                    _userUid, court.id, court.latitude, court.longitude))),
        child: new Container(
          decoration: new BoxDecoration(
            color: colorFlag ? Colors.blue[300] : Colors.red[300],
            borderRadius: new BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
          padding: new EdgeInsets.all(20.0),
          margin: new EdgeInsets.fromLTRB(4.0, 12.0, 4.0, 8.0),
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
                      title: new Text(
                          (court.distance / 1000.0).toStringAsFixed(2) +
                              ' miles away'),
                    ),
                    new ListTile(
                      leading: new Icon(Icons.panorama_fish_eye),
                      title: new Text(
                          court.courtType ? 'Full-court' : 'Half-court'),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _buildCourtList(List courts, Map<String, double> currentLocation) {
    num curLat = currentLocation["latitude"];
    num curLon = currentLocation["longitude"];

    List<Widget> displayList = [
      new Container(
        margin: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: new Text(
            this.results.toString() + " courts found" + " near you." + "\n",
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.bold,
                fontSize: 18.0)),
      ),
      new RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new FilterScreen(
                      userUid: _userUid,
                    )),
          );
        },
        child: new Text('Filter courts'),
      ),
    ];

    Iterable<Widget> courtDisplays = courts.map((courtData) {
      num courtLat = courtData['data']["latitude"];
      num courtLon = courtData['data']["longitude"];
      double distance = _calculateDistance(curLon, curLat, courtLon, courtLat);
      return _getCourtDisplay(new Court(
          'images/ruckerpark.jpg',
          courtData['data']['name'],
          true,
          distance,
          courtLat,
          courtLon,
          courtData['id']));
    });
    displayList.addAll(courtDisplays);
    return displayList;
  }

  CourtScreenState(String location, this._userUid) {
    this.location = location;
  }

  @override
  void initState() {
    var userLocation = new Location();
    ApiFunctions.getAllCourts().then((courts) {
      userLocation.getLocation.then((currentLocation) {
        setState(() {
          results = courts.length;
          courtDisplayList = _buildCourtList(courts, currentLocation);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Courts"),
          backgroundColor: Colors.black,
        ),
        body: new ListView(children: courtDisplayList));
  }
}
