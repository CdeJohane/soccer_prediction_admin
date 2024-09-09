import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MatchDetailsPage extends StatelessWidget {
  const MatchDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixture'),
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
                  child: const Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text('Manchester United', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('-', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),)
                              )
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text('Manchester City', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('-', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),)
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
              child: ListView.builder(
                itemCount: 15,
                itemBuilder:(context, index) {
                  return GestureDetector(
                  onTap: () {
                    // Relocate to amtch details page
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const MatchDetailsPage())
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
                  ),
                );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}