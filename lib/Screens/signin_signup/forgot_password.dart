import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/textinput.dart';
import '../../constant/color.dart';
import '../../constant/global.dart';
import 'otp.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String mobile = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: appBar(context: context, title: "Forgot Password"),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage("assets/images/login_register_background.png"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Image(
              image: AssetImage("assets/images/message.png"),
              height: 200,
              width: 200,
            ),
            input(
                style: TextStyle(fontSize: 17),
                autoFocus: true,
                context: context,
                text: "Mobile Number",
                onChanged: (value) {
                  setState(() {
                    mobile = value;
                  });
                },
                keyboardType: TextInputType.number,
                onEditingComplete: _forgotPassword),
            SizedBox(
              height: 40,
            ),
            Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  child: Text("GET OTP"),
                  onPressed: isLoading ? null : _forgotPassword,
                  color: primaryColor,
                )),
          ],
        ),
      ),
    );
  }

  _forgotPassword() async {
    if (mobile.isNotEmpty &&
        RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(mobile)) {

    } else {
      Fluttertoast.showToast(msg: "Please enter valid mobile number");
    }
  }
}
