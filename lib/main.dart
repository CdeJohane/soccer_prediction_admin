import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccer_predict_admin/pages/main_screen.dart';


void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Soccer Prediction Admin',
        home: MainPage()
      ),
    )
  );
}

