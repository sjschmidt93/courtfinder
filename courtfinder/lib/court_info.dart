import 'package:courtfinder/api.dart';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class CourtInfo extends StatefulWidget {
  final String _userToken;
  final String _courtId;
  final num _latitude;
  final num _longitude;
  List games = [];

  CourtInfo(this._userToken, this._courtId, this._latitude, this._longitude);

  @override
  State<StatefulWidget> createState() {
    return new CourtInfoState(_userToken, _courtId, _latitude, _longitude);
  }
}

class CourtInfoState extends State<CourtInfo> {
  final String _userToken;
  final String _courtId;
  final num _latitude;
  final num _longitude;
  List gamesList = [];
  Uri staticMapUri;
  StaticMapProvider provider =
      new StaticMapProvider("AIzaSyAebXKKhNZ3XQfzFrHP4MT7wtqvBiDn4IE");

  CourtInfoState(
      this._userToken, this._courtId, this._latitude, this._longitude);

  Widget _buildBodyListView() {
    List<Widget> tiles = [
      new Image.network(staticMapUri.toString()),
    ];
    Iterable<Widget> gameTiles = gamesList.map((game) {
      final time = game['time'];
      return new ListTile(
        title: time,
      );
    });
    tiles.addAll(gameTiles);
    return new ListView(
      children: tiles,
    );
  }

  @override
  void initState() {
    Marker locMarker = new Marker("1", "Court", _latitude, _longitude);
    staticMapUri = provider.getStaticUriWithMarkers([locMarker],
        center: new Location(_latitude, _longitude),
        width: 900,
        height: 400,
        maptype: StaticMapViewType.roadmap);
    super.initState();
    ApiFunctions.getGamesForCourt(_courtId).then((result) {
      setState(() {
        gamesList = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("$_latitude, $_longitude"),
      ),
      body: _buildBodyListView(),
    );
  }
}
