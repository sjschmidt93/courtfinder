import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
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
                image: new DecorationImage(image: new AssetImage("assets/court.png"), fit: BoxFit.cover,),
              ),
            ),
            new Center(
              child: new Text("Hello background"),
            )
          ],
        )
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
}