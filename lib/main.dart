import 'package:e_commerce/UI/category.dart';
import 'package:e_commerce/otp.dart';
import 'package:e_commerce/signup.dart';
import 'package:flutter/material.dart';

import 'otp_screen.dart';

void main()
{
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
      home: OTP(),
      // home: Category(title: "Saree",),
      theme: ThemeData(
        // fontFamily: "Segoe UI"
      ),
    );
  }
}
