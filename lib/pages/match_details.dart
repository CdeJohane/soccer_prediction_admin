import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soccer_predict_admin/components/modifyPrediction.dart';
import 'package:soccer_predict_admin/controller/player_request.dart';
import 'package:soccer_predict_admin/controller/prediction_request.dart';
import 'package:soccer_predict_admin/data/teams.dart';

class MatchDetailsPage extends StatelessWidget {
  final match;

  const MatchDetailsPage({super.key, this.match});

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> getPlayers = getAllPlayers();
    return Scaffold(
      appBar: AppBar(
        title: match['complete'] == 0 ? const Text('Fixture') : const Text('Result'),
        actions: [match['complete'] == 0 ?  ModPredictionBtn(players: getPlayers, match_id: match['id'],) : const SizedBox.shrink()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Card(
                elevation: 50,
                color: Colors.grey[800],
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(teams[match['home_team_code']]!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(match['complete'] == 0 ? '-' : match['home_score'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),)
                              )
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(teams[match['away_team_code']]!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(match['complete'] == 0 ? '-' : match['away_score'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),)
                              )
                            )
                          ],
                        )
                      ],
                    )
                  )
                ),
              )
            ),
            Expanded(
              flex: 8,
              child: FutureBuilder(
                future: getMatchPrediction(match['id']), 
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                  // Check the state of the Future
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading');  // Show loading indicator while waiting
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));  // Show error if any
                  } else if (snapshot.hasData) {
                    // Access the List<dynamic> once data is available
                    int length = snapshot.data?.length ?? 0;  // Get the length of the list
                    return ListView.builder(
                      itemCount: length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[200]!
                                )
                              )
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Align(alignment: Alignment.centerLeft ,child:Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text('Player Selected', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),),
                                  )),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Align(alignment:Alignment.center, child: Text('Home', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),))
                                )
                              ]
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No Predictions available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}