import 'package:flutter/material.dart';
import 'package:soccer_predict_admin/controller/results_request.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<int> items = List<int>.generate(38, (index) => index + 1);
  int? match_week = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // One to select the Gameweek
        Expanded(
          flex: 1,
          child: Container(
            child: DropdownButton<int>(
              isExpanded: true,
              style: TextStyle(color: Colors.white),
              items: items.map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    match_week = value;
                  });
                },
            ),
          ),
        ),
        // Another to show the results of the Matchweek
        Expanded(
          flex: 9,
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Text('MatchDay $match_week', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                ),
                Expanded(flex: 11, child: Center(
                  child: FutureBuilder(future: getMatchResults(match_week!), builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading');  // Show loading indicator while waiting
                    } else if (snapshot.hasError) {
                      return Text('Mate, no results here yet');  // Show error if any
                    } else if (snapshot.hasData){
                       int length = snapshot.data?.length ?? 0;
                       return ListView.builder(
                        itemCount: length,
                        itemBuilder:(context, index) {
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
                                    flex: 3,
                                    child: Align(alignment: Alignment.center ,child:Text('${snapshot.data?[index]['home_team_code']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(alignment: Alignment.center, child: Text('-', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),))
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Align(alignment:Alignment.center, child: Text('${snapshot.data?[index]['away_team_code']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),))
                                  )
                                ]
                              ),
                            ),
                          );
                        },
                       );
                    }
                    else{
                      return Text('Nothing here to see mate');
                    }
                    }
                  )
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}