import 'package:e_commerce/Screens/HomeScreen.dart';
import 'package:e_commerce/UI/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {

  static Color primaryColor = Color(0xffeb3434);

  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      allowFontScaling: false,
      builder: ()=> MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
          // home: Category(title: "Saree",),
          theme: ThemeData(
            // fontFamily: "Segoe UI"
            accentColor: Myapp.primaryColor,
            primaryColor: Myapp.primaryColor,
          ),
        ),
    );
  }
}
