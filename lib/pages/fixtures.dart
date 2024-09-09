import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soccer_predict_admin/controller/fixtures_request.dart';
import 'package:soccer_predict_admin/pages/match_details.dart';

class FixturesPage extends StatelessWidget {
  const FixturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getAllFixtures(), 
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          // Check the state of the Future
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');  // Show loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');  // Show error if any
          } else if (snapshot.hasData) {
            // Access the List<dynamic> once data is available
            int length = snapshot.data?.length ?? 0;  // Get the length of the list
            return ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Relocate to amtch details page
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MatchDetailsPage(match: snapshot.data?[index],))
                    );
                  },
                  child: SizedBox(
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
                  ),
                );
              },
            );
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }
}