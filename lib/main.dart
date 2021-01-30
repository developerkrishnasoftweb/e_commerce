import 'package:e_commerce/UI/Homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      // home: Category(title: "Saree",),
      theme: ThemeData(
          // fontFamily: "Segoe UI"
          ),
    );
  }
}
