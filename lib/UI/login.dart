import 'package:e_commerce/UI/Homepage.dart';
import 'package:e_commerce/UI/otp.dart';
import 'package:e_commerce/UI/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/NavigationDrawer.dart';

class LogIn extends StatefulWidget {
  String get title => "";

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text("LogIn", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            backgroundColor: Color(0xff4E72D4),
            leading: IconButton(
                icon: ImageIcon(AssetImage("assets/icons/menu.png"), color: Colors.white),
                onPressed: () => _scaffoldKey.currentState.openDrawer())),
        // leading: IconButton(icon: ImageIcon(AssetImage("assets/icons/left-arrow.png"), color: Colors.white))),
        drawer: navigationDrawer(),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25),
            physics: BouncingScrollPhysics(),
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              SizedBox(height: 15),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal), borderRadius: BorderRadius.circular(10)),
                      hintText: "Email Or Mobile")),
              SizedBox(height: 15),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal), borderRadius: BorderRadius.circular(10)),
                      hintText: "Password")),
              SizedBox(height: 30),
              Container(
                  width: size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.lightBlue[100], blurRadius: 10, offset: Offset(0, 5))
                  ]),
                  child: FlatButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Homepage())),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Text("LogIn",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                      color: Color(0xff4E72D4))),
              SizedBox(height: 15),
              Text("Or with", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Container(
                  width: size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.lightBlue[100], blurRadius: 10, offset: Offset(0, 5))
                  ]),
                  child: FlatButton.icon(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      icon: ImageIcon(AssetImage("assets/icons/fb.png"), color: Colors.white),
                      label: RichText(
                          text: TextSpan(
                              text: "Continue With ",
                              style: TextStyle(fontSize: 20, color: Color(0xffCBCBCB)),
                              children: [
                            TextSpan(
                                text: "Facebook", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                          ])),
                      color: Color(0xff3C5A99))),
              SizedBox(height: 15),
              Container(
                  width: size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey[400], blurRadius: 5, offset: Offset(0, 2))]),
                  child: FlatButton.icon(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      icon: Image.asset("assets/icons/google.png"),
                      label: RichText(
                          text: TextSpan(
                              text: "Continue With ",
                              style: TextStyle(fontSize: 20, color: Colors.grey),
                              children: [
                            TextSpan(text: "Google", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))
                          ])),
                      color: Color(0xffF8F8F8))),
              Container(height: 50),
              Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => signup())),
                    child: RichText(
                        text: TextSpan(text: "Don't Have an Account? ", style: TextStyle(fontSize: 20,color: Colors.grey),
                            /*defining default style is optional */
                            children: <TextSpan>[
                      TextSpan(text: 'SignUp', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black))
                    ])),
                  ))
            ])));
  }
}
