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


  void _toggleGame(Map participants, String creator, String gameId) async {
    if (participants.containsKey(_userToken) && participants[_userToken]) {
      await ApiFunctions.removeUserGame(gameId, _userToken);
    }
    else {
      await ApiFunctions.addUserGame(gameId, _userToken);
    }
    _reloadGames();
  }

  Widget _buildBodyListView() {
    List<Widget> tiles = [
      new Image.network(staticMapUri.toString()),
    ];
    Iterable<Widget> gameTiles = gamesList.map((game) {
      final String creator = game['creator'];
      final String gameId = game['id'];
      final Map participants = game['participants'];
      final timeField = game['time'];
      final DateTime time = DateTime.parse(timeField);
      final int year = time.year;
      final int month = time.month;
      final int day = time.day;
      final int hour = time.hour;
      final int minute = time.minute;
      return new ListTile(
        title: new Text("$month-$day-$year, $hour:$minute"),
        leading: ((participants.containsKey(_userToken) && participants[_userToken]))
            ? new Icon(Icons.check_box)
            : new Icon(Icons.check_box_outline_blank),
        onTap: () => _toggleGame(participants, creator, gameId),
      );
    });
    tiles.addAll(gameTiles);
    return new ListView(
      children: tiles,
    );
  }

  _reloadGames() async {
    final result = await ApiFunctions.getGamesForCourt(_courtId);
    setState(() {
      gamesList = result;
    });
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
    _reloadGames();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime curTime = new DateTime.now();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("$_latitude, $_longitude"),
      ),
      body: _buildBodyListView(),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () => showDatePicker(
                      context: context,
                      initialDate: curTime,
                      firstDate: curTime,
                      lastDate: new DateTime.now().add(new Duration(days: 30)))
                  .then((selectedDate) async {
                final TimeOfDay selectedTime = await showTimePicker(
                    context: context,
                    initialTime: new TimeOfDay.fromDateTime(curTime));
                final Duration dayTime = new Duration(
                    hours: selectedTime.hour, minutes: selectedTime.minute);
                final DateTime timeToSave = selectedDate.add(dayTime);
                print(timeToSave);
                await ApiFunctions.scheduleGame(
                    _courtId, _userToken, timeToSave.millisecondsSinceEpoch);
                _reloadGames();
              })),
    );
  }
}
