import 'package:codinomeapp/views/home_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(CodinomeApp());

class CodinomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codinome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
