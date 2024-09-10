import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soccer_predict_admin/controller/player_request.dart';
import 'package:http/http.dart' as http;

class ModPredictionBtn extends StatefulWidget {
  final players;
  final match_id;
  const ModPredictionBtn({super.key, this.players, this.match_id});

  @override
  State<ModPredictionBtn> createState() => _ModPredictionBtnState();
}

class _ModPredictionBtnState extends State<ModPredictionBtn> {
  int? player_id;
  int? home_or_away;

  @override
  Widget build(BuildContext context) {
    final _futureBuilderKey = GlobalKey();
    final _SecondKey = GlobalKey();
    return TextButton(
      onPressed: () {
        const predictionValue = [
          'Draw',
          'Home',
          'Away'
        ];
        // Convert Players to a doable list
       Map<int, String> playerList= {};

        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text('Add/Mod Prediction'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  // Text to Signal Player
                  const Text('Player'),
                  // Get the value
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: FutureBuilder(
                      key: _futureBuilderKey,
                      future: widget.players,
                      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
                        if(snapshot.hasData){
                          return DropdownButton<dynamic>(
                            isExpanded: true,
                            value: player_id,
                            items: snapshot.data!.map<DropdownMenuItem<dynamic>>((var value) {
                              return DropdownMenuItem<dynamic>(
                                value: value['id'],
                                child: Text(value['player_name'], style: const TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                            onChanged: (newVal){
                              setState(() {
                                player_id = newVal;
                                _futureBuilderKey.currentState?.setState(() {});
                              });
                            },
                          );
                        } else {
                          return Text('Some error');
                        }
                      },
                    ),
                  ),
                  // Text to Signal Player
                  const Text('Prediction'),
                  Column(
                    children: [
                      RadioListTile(value: 1, groupValue: home_or_away, onChanged: (val){setState(() {
                        home_or_away = 1;
                      });}, title: Text('Home'),selected: home_or_away == 1,activeColor: Colors.green,),
                      RadioListTile(value: 0, groupValue: home_or_away, onChanged: (val){setState(() {
                        home_or_away = 0;
                      });}, title: Text('Draw'),selected: home_or_away == 0,activeColor: Colors.green,),
                      RadioListTile(value: 2, groupValue: home_or_away, onChanged: (val){setState(() {
                        home_or_away = 2;
                      });}, title: Text('Away'),selected: home_or_away == 2,activeColor: Colors.green,),
                    ],
                  ),
                  /*
                  SizedBox(
                    key: _SecondKey,
                    height: 60,
                    width: double.infinity,
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: home_or_away,
                      items: predictionValue.map<DropdownMenuItem<int>>((String myString){
                        return DropdownMenuItem<int>(
                          value: predictionValue.indexOf(myString),
                          child: Text(myString),
                        );
                      }).toList(),
                      onChanged: (newPred){
                        setState(() {
                          home_or_away = newPred;
                          print(home_or_away);
                          _SecondKey.currentState?.setState(() {});
                        });
                      },
                    ),
                  )*/
                ],
              ),
            ),
              actions: [
                // One button For Proceed, another to cancel
                TextButton(
                onPressed: () async{
                  // Name has to be >3 Characters
                    final Map<String, dynamic> data = {
                      'player_id':player_id!,
                      'match_id': widget.match_id,
                      'home_or_away' : home_or_away
                    };
                    // Send Details to database for verification and addition
                    var httpResponse = await http.post(
                      Uri.parse(dotenv.env['BACKEND_SITE_ADD_PREDICTION']!),
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
                },
                child: Text('Proceed')
              ),
              TextButton(
                onPressed: (){
                  Fluttertoast.showToast(msg: "Cancelled");
                  Navigator.pop(context);
                },
                child: const Text('Cancel')
              ),
            ],
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text('Add Prediction', style: TextStyle(color: Colors.grey[500]),),
      ),
    );
  }
}