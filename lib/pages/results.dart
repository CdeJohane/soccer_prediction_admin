import 'package:flutter/material.dart';

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
                Expanded(flex: 8, child: Center(child: Text('My Text')))
              ],
            ),
          ),
        )
      ],
    );
  }
}