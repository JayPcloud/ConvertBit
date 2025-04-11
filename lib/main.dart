import 'package:converter/view/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.blueGrey, width: 0.5)),
          enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.grey, width: 0.5)),
          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 0.5))
        )
      ),
      home: HomePg(),
    );
  }
}


