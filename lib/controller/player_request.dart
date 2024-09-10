import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getAllPlayers() async{
  var result = await http.get(Uri.parse(dotenv.env['BACKEND_SITE_ALL_PLAYERS']!));
  var resultArray = jsonDecode(result.body);
  return resultArray;
}

Future<String> getPlayerName(int player_id) async {
  List<dynamic> playerList = await getAllPlayers();
  String value = '';
  for (var player in playerList){
    if(player_id == player['id']){
      value = player['player_name'];
      break;
    }
  }
  return value;
}