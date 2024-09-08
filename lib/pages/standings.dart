import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
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
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left:18.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('${index+1}'),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(snapshot.data?[index]['player_name'])
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('${snapshot.data?[index]['points']}')
                        )
                      ]
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