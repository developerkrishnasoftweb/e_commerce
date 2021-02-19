import 'package:e_commerce/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUp", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          physics: BouncingScrollPhysics(),
          child:
              Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            SizedBox(height: 15),
            Text("Please enter your detail",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 15),
            TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal), borderRadius: BorderRadius.circular(5.sp)),
                    hintText: "First Name")),
            SizedBox(height: 15),
            TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal), borderRadius: BorderRadius.circular(5.sp)),
                    hintText: "Last Name (Optional)")),
            SizedBox(height: 15),
            TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal), borderRadius: BorderRadius.circular(5.sp)),
                    hintText: "Email Id (Optional)")),
            SizedBox(height: 30),
            Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.lightBlue[100], blurRadius: 10, offset: Offset(0, 5))
                ]),
                child: FlatButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen())),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child:
                        Text("Next", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                    color: Myapp.primaryColor)),
          ])),
    );
  }
}
