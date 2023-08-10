import 'package:flutter/material.dart';
import 'package:flutterstudy/home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.amber.shade300,
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color.fromARGB(255, 242, 236, 201),
          ),
        ),
        cardColor: const Color.fromARGB(255, 108, 69, 180),
      ),
      home: const Home(),
    );
  }
}
