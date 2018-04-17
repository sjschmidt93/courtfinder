import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: 'courtfinder',
    home: new HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'courtfinder',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('courtfinder'),
          backgroundColor: Colors.black
        ),
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("images/court.png"), fit: BoxFit.cover,),
              ),
            ),
            new Column (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new LocationScreen()),
                          );
                        },
                        child: new Text('Pick your location'),
                      ),  
                      new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new CourtScreen()),
                          );
                        },
                        child: new Text('Find courts'),
                      )
                    ]
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new LocationScreen()),
                          );
                        },
                        child: new Text('Login'),
                      ),  
                      new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new LocationScreen()),
                          );
                        },
                        child: new Text('Settings'),
                      ),  
                    ]
                  )
                ]
              ),

          ],
        )
      ),
    );
  }
}

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: [
          new Image.asset(
            'images/newyork.jpg',
            height: 240.0,
            fit: BoxFit.cover,
          ),
          new Image.asset(
            'images/losangeles.jpg',
            height: 240.0,
            fit: BoxFit.cover,
          ),
          new Image.asset(
            'images/chicago.jpg',
            height: 240.0,
            fit: BoxFit.cover,
          ),                    
        ],
      )
    );
  }
}

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

