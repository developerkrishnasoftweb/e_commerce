import 'package:e_commerce/Screens/SignupScreen.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/NavigationDrawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogIn extends StatefulWidget {
  String get title => "";

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("LogIn", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        // leading: IconButton(icon: ImageIcon(AssetImage("assets/icons/left-arrow.png"), color: Colors.white))),
        drawer: navigationDrawer(),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            physics: BouncingScrollPhysics(),
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              SizedBox(height: 15),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal), borderRadius: BorderRadius.circular(5.sp)),
                      hintText: "Mobile Number")),
              SizedBox(height: 30),
              Container(
                  width: size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.lightBlue[100], blurRadius: 10, offset: Offset(0, 5))
                  ]),
                  child: FlatButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen())),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Text("Next",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                      color: Myapp.primaryColor)),
            ])));
  }
}
