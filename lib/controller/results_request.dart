import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getMatchResults(int match_week) async{
  // Cerate json for sending data
  final Map<String, int> data = {
    'match_week': match_week,
  };
  // Send Details to database for verification and addition
  var httpResponse = await http.post(
    Uri.parse(dotenv.env['BACKEND_SITE_GET_RESULTS']!),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data)
  );
  if (httpResponse.statusCode == 200){
    var resultArray = jsonDecode(httpResponse.body);
    return resultArray;
  } else {
    Fluttertoast.showToast(msg: "Error. Please try again, or add a different name");
    return Future.value([]);
  }
}