import 'package:flutter/material.dart';
import 'package:testcaninno/pages/loginpage.dart';
import 'package:testcaninno/style/constant_color.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(color: Constant_Color().red),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
        ),
      ),
      home: const Loginpage(),
    );
  }
}
