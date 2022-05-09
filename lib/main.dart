import 'package:flutter/material.dart';
import 'package:todoapp/tasks.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODO",
      color: Color(0xFF03989E),
      debugShowCheckedModeBanner: false,
      home: focustask(),
    );
  }
}
