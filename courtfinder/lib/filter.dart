import 'package:flutter/material.dart';
import 'court.dart';

// create a filter class which is then passed to the Court Screen after changes are saved
class Filter {
  bool newYork;
  bool chicago;
  bool la;
  double radius;
  Filter(this.newYork, this.chicago, this.la, this.radius);
}

class FilterScreen extends StatefulWidget {
  final String userUid;

  const FilterScreen({Key key, this.userUid}) : super(key: key);

  @override
  FilterScreenState createState() => new FilterScreenState(userUid);
}

class FilterScreenState extends State<FilterScreen> {
  final String userToken;
  bool newYork = true;
  bool chicago = true;
  bool la = true;
  double radius = 1.0;

  FilterScreenState(this.userToken);

  void handleNewYorkTap(bool newValue) {
    setState(() {
      newYork = newValue;
    });
  }

  void handleChicagoTap(bool newValue) {
    setState(() {
      chicago = newValue;
    });
  }

  void handleLATap(bool newValue) {
    setState(() {
      la = newValue;
    });
  }

  void handleRadiusChange(String newValue) {
    setState(() {
      radius = double.parse(newValue);
    });
  }

  getCallBackForSwitch(String locationName) {
    switch (locationName) {
      case 'New York':
        return handleNewYorkTap;
      case 'Chicago':
        return handleChicagoTap;
      case 'Los Angeles':
        return handleLATap;
    }
  }

  getStateParamForSwitch(String locationName) {
    switch (locationName) {
      case 'New York':
        return newYork;
      case 'Chicago':
        return chicago;
      case 'Los Angeles':
        return la;
    }
  }

  getRowWithSwitch(String locationName) {
    return new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      new Switch(
        value: getStateParamForSwitch(locationName),
        onChanged: getCallBackForSwitch(locationName),
      ),
      new Text(locationName),
    ]);
  }

  static const MIN = 1.0;
  static const MAX = 10.0;
  static const INC = 1.0;

  @override
  Widget build(BuildContext context) {
    // creates a list of doubles for the dropdownbutton widget
    var list = [];
    for (double d = MIN; d <= MAX; d += INC) list.add(d);

    return new Scaffold(
        body: new Container(
            decoration: new BoxDecoration(
              color: new Color(0x1F3860FF),
              borderRadius: new BorderRadius.all(
                const Radius.circular(8.0),
              ),
            ),
            child: new Column(children: [
              new Row(children: [
                new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text('Filter based on location:'),
                      getRowWithSwitch('New York'),
                      getRowWithSwitch('Chicago'),
                      getRowWithSwitch('Los Angeles'),
                    ]),
                new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text('Select search radius:'),
                      new DropdownButton<String>(
                        value: radius.toString(),
                        items: list.map((value) {
                          return new DropdownMenuItem<String>(
                            value: value.toString(),
                            child: new Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: handleRadiusChange,
                      ),
                    ])
              ]),
              new Row(children: [
                // when user saves their changes, pass Filter object to CourtScreen and render accordingly
                new RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new CourtScreen('New York', 3, userToken, radius.toString())),
                    );
                  },
                  child: new Text('Save your changes'),
                ),
                // when user cancels their changes, pass NULL to CourtScreen
                new RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new CourtScreen('New York', 3, userToken, null)),
                    );
                  },
                  child: new Text('Cancel'),
                ),
              ])
            ])));
  }
}
