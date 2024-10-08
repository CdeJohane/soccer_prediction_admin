import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccer_predict_admin/pages/main_screen.dart';


void main() async{
  
  await dotenv.load(fileName: './.env');
  runApp(
    ProviderScope(
      child: MaterialApp(
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Soccer Prediction Admin',
        home: MainPage()
      ),
    )
  );
}

