import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ModPredictionBtn extends StatelessWidget {
  const ModPredictionBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text('Add Prediction', style: TextStyle(color: Colors.grey[500]),),
      ),
    );
  }
}