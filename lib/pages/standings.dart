import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soccer_predict_admin/controller/player_request.dart';

class StandingsPage extends StatelessWidget {
  const StandingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getAllPlayers(), 
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
                    String myText = snapshot.data?[index]['player_name'];
                    Fluttertoast.showToast(
                      msg: "$myText has been pressed",
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.grey[700],
                      textColor: Colors.white70
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
                      child: Padding(
                        padding: const EdgeInsets.only(left:18.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('${index+1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(snapshot.data?[index]['player_name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),)
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('${snapshot.data?[index]['points']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),)
                            )
                          ]
                        ),
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