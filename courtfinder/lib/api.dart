import 'dart:async';
import 'package:fire_functions/fire_functions.dart';

class ApiFunctions {
  static Future<Map> addUserGame(String userId, String gameId) async {
    Map<String, dynamic> data = {
      "gameId": gameId,
      "userId": userId,
    };
    return await FireFunctions.callFunction("addUserGame", data);
  }

  static Future<Map> getGameInfo(String gameId) async {
    Map<String, dynamic> data = {
      "id": gameId
    };
    return await FireFunctions.callFunction("getGameInfo", data);
  }

  static Future<List> getNearbyCourts(double latitude, double longitude, double range) async {
    Map<String, dynamic> data = {
      "location": {
        "latitude": latitude,
        "longitude": longitude,
      },
      "range": range,
    };
    return await FireFunctions.callFunction("getNearbyCourts", data);
  }

  static Future<Map> removeUserGame(String gameId, String userId) async {
    Map<String, dynamic> data = {
      "gameId": gameId,
      "userId": userId,
    };
    return await FireFunctions.callFunction("removeUserGame", data);
  }

  static Future<Map> scheduleGame(String courtId, String userId, DateTime time) async {
    Map<String, dynamic> data = {
      "userId": userId,
      "courtId": courtId,
      "time": time,
    };
    return await FireFunctions.callFunction("scheduleGame", data);
  }

  static Future<List> getGamesForCourt(String courtId) async {
    Map<String, dynamic> data = {
      "courtId": courtId,
    };
    return await FireFunctions.callFunction("getGamesForCourt", data);
  }

  static Future<List> getAllCourts() async {
    return await FireFunctions.callFunction("getAllCourts", {});
  }

  static Future<List> getAllGames() async {
    return await FireFunctions.callFunction("getAllGames", {});
  }
}