import 'package:e_commerce/UI/Homepage.dart';
import 'package:e_commerce/UI/login.dart';
import 'package:e_commerce/UI/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/NavigationDrawer.dart';

class signup extends StatefulWidget {
  String get title => "";

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text("SignUp", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            backgroundColor: Color(0xff4E72D4),
            leading: IconButton(
                icon: ImageIcon(AssetImage("assets/icons/menu.png"), color: Colors.white),
                onPressed: () => _scaffoldKey.currentState.openDrawer())),
        // leading: IconButton(icon: ImageIcon(AssetImage("assets/icons/left-arrow.png"), color: Colors.white))),
        drawer: navigationDrawer(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            physics: BouncingScrollPhysics(),
            child: Column(children: <Widget>[
              SizedBox(height: 15),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal), borderRadius: BorderRadius.circular(10)),
                      hintText: "Email Address")),
              SizedBox(height: 15),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal), borderRadius: BorderRadius.circular(10)),
                      hintText: "Password")),
              SizedBox(height: 15),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal), borderRadius: BorderRadius.circular(10)),
                      hintText: "Confirm Password")),
              SizedBox(height: 15),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal), borderRadius: BorderRadius.circular(10)),
                      hintText: "Mobile Number")),
              SizedBox(height: 30),
              Container(
                  width: size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.lightBlue[100], blurRadius: 10, offset: Offset(0, 5))
                  ]),
                  child: FlatButton(
                      onPressed: () =>
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OTP())),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Text("SignUp",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                      color: Color(0xff4E72D4))),
              Container(height: 50),
              Center(
                  child: GestureDetector(
                      onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LogIn())),
                      child: RichText(
                          text: TextSpan(
                              text: "Already Have an Account? ",
                              style: TextStyle(fontSize: 20, color: Colors.grey),
                              children: <TextSpan>[
                            TextSpan(
                                text: 'LogIn',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
                          ]))))
            ])));
  }
}
