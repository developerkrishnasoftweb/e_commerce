import 'package:e_commerce/UI/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'category.dart';

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  FocusNode textFocusNode = new FocusNode();
  String otp = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: appBarIconButton(
                imagePath: "assets/icons/left-arrow.png", color: Colors.white, onPressed: () => Navigator.pop(context)),
            title: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
            centerTitle: false,
            backgroundColor: Color(0xff4E72D4)),
        body: Column(children: [
          SizedBox(height: 10),
          RichText(
              text: TextSpan(
                  text: "Please enter OTP send to ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                  children: [
                TextSpan(
                    text: "+91 8758431417",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xff4E72D4)))
              ])),
          SizedBox(width: size.width, height: 30),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                for (int i = 0; i < 4; i++) ...[buildOtpTextField()]
              ]))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: GestureDetector(
                  onTap: () {},
                  child: Text("RESEND OTP",
                      style: TextStyle(color: Color(0xff4E72D4), fontSize: 17, fontWeight: FontWeight.bold)))),
          SizedBox(
            height: 70,
            width: size.width * 0.9,
            child: FlatButton(
                child: Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 20)),
                color: Color(0xff4E72D4),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Homepage())),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          )
        ]));
  }

  Widget buildOtpTextField() {
    return SizedBox(
        height: 60,
        width: 60,
        child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(width: 2)),
                contentPadding: EdgeInsets.all(20)),
            keyboardType: TextInputType.number,
            maxLength: 1,
            buildCounter: (BuildContext context, {int currentLength, int maxLength, bool isFocused}) => null,
            onChanged: (value) {
              if (value.isEmpty) {
                if (otp != null && otp.length > 0) {
                  setState(() {
                    otp = otp.substring(0, otp.length - 1);
                  });
                }
                FocusScope.of(context).previousFocus();
              }
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
                setState(() {
                  otp += value;
                });
              }
            },
            cursorColor: Color(0xff4E72D4),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center));
  }
}
