import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getAllPlayers() async{
  var result = await http.get(Uri.parse(dotenv.env['BACKEND_SITE_ALL_PLAYERS']!));
  var resultArray = jsonDecode(result.body);
  return resultArray;
}