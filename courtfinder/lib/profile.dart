import 'package:flutter/material.dart';

// screeen that displays a user's profile, will be passed relevant infromation from the home screen through
// the profile screen constructor

class ProfileScreen extends StatelessWidget {

  String useruid;
  String userEmail;
  String userName;
  String photoUrl;

  ProfileScreen(this.useruid, this.userEmail, this.userName, this.photoUrl);

  final TextStyle infoStyle = new TextStyle(
    fontSize: 28.0,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    if(useruid == null){
      return new Scaffold(
        body: new Center(
          child: new Text("You are not logged in."),
        )
      );
    }
    return new Scaffold(
      body: new Container(
          decoration: new BoxDecoration(
            color: new Color(0x1F3860FF),
            borderRadius: new BorderRadius.all(
              const Radius.circular(8.0),
            ),
          ),
      child: new Column(
        children: [
          new Container(
            child:
              new Text(
                "Your courtfinder's profile",
                style: infoStyle,
              ),        
              padding: new EdgeInsets.all(20.0),
          ),
          new Row(
            children: [
              new Column(
                children: [
                  new Image.network(photoUrl),
                  new Text(userName),
                ]
              ),
              new Column(
                children: [
                  new Text("Games played: 14\n Record: 7-7-0"),
                  new RaisedButton(
                    child: new Text("View game history")
                  )
                ]
              )
            ],
          )

        ],
      )
    ));
  }
}