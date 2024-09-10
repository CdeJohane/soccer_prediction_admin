import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Placeresult extends StatefulWidget {
  final int match_id;
  final int checkComplete;

  const Placeresult({super.key, required this.match_id, required this.checkComplete});

  @override
  State<Placeresult> createState() => _PlaceresultState();
}

class _PlaceresultState extends State<Placeresult> {
  // Controllers for home and away Scores
  TextEditingController home_score = TextEditingController();
  TextEditingController away_score = TextEditingController();
  int _complete = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Scores'),
      content: Column(
        children: [
          // Home Score
          Text('Home Score'),
          TextField(
            controller: home_score,
            decoration: InputDecoration(hintText: 'Home Score'),
          ),
          // Away Score
          Text('Away Score'),
          TextField(
            controller: away_score,
            decoration: InputDecoration(hintText: 'Away Score'),
          ),
        ],
      ),
      actions: [
        // Proceed
        TextButton(onPressed: ()async {
          // Get int of scpre
          final int hScore = int.parse(home_score.text);
          final int aScore = int.parse(away_score.text);

          // Validate
          if ((hScore<0) || (aScore<0)){
            Fluttertoast.showToast(msg: "INVALID SCORE");
          } else {
            // Get Winner
            int diff = hScore - aScore;
            if (diff > 0){
              diff = 1;
            } else if (diff <0){
              diff = 2;
            }
            // Prepare dictionary for shipping
            Map<String, dynamic> data = {
              'match_id' : widget.match_id,
              'home_score' : hScore,
              'away_score' : aScore,
              'winner' : diff
            };
            // Ship it
            // Send Details to database for verification and addition
                    var httpResponse = await http.post(
                      Uri.parse(dotenv.env['BACKEND_SITE_UPDATE_MATCH']!),
                      headers: {
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode(data)
                    );
                    if (httpResponse.statusCode == 200){
                      Fluttertoast.showToast(msg: "Prediction has been added");
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(msg: "Error. Please try again, or add a different name");
                    }
          }

        }, child: Text('Proceed')),
      ],
    );
  }
}