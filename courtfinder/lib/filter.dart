import 'package:flutter/material.dart';
import 'court.dart';

class FilterScreen extends StatefulWidget { 
    @override
    FilterScreenState createState() => new FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> { 

  bool newYork = true;
  bool chicago = true;
  bool la = true;
  double radius = 1.0;

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
    switch(locationName) {
      case 'New York':
        return handleNewYorkTap;
      case 'Chicago':
        return handleChicagoTap;
      case 'Los Angeles':
        return handleLATap;                
    }
  }


  getStateParamForSwitch(String locationName) { 
    switch(locationName) {
      case 'New York':
        return newYork;
      case 'Chicago':
        return chicago;
      case 'Los Angeles':
        return la;                
    }
  }

  getRowWithSwitch(String locationName) { 
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Switch(
            value: getStateParamForSwitch(locationName),
            onChanged: getCallBackForSwitch(locationName),
          ),
          new Text(locationName),
        ]
      );
  }

  static const MIN = 1.0;
  static const MAX = 10.0;
  static const INC = 1.0;

  @override
  Widget build(BuildContext context) { 

    // creates a list of doubles for the dropdownbutton widget
    var list = [];
    for(double d = MIN; d <=MAX; d+=INC)
      list.add(d);

    return new Scaffold(
      body: new Column( 
        children: [ 
          new Row(
            children: [
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Text('Filter based on location:'),
                  getRowWithSwitch('New York'),
                  getRowWithSwitch('Chicago'),
                  getRowWithSwitch('Los Angeles'),
                ]
              ),
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
                ]
              )
            ]
          ),
          new Row(
            children: [
              new RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new CourtScreen('New York', 3)),
                  );
                },
                child: new Text('Save your changes.'),
              ),  
            ]
          ) 
        ]
      )
    );
  }
}

