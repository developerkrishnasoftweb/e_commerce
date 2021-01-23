import 'package:flutter/material.dart';

class otp_screen extends StatefulWidget {
  @override
  _otp_screenState createState() => _otp_screenState();
}

class _otp_screenState extends State<otp_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
            icon: ImageIcon(
          AssetImage("assets/icons/left-arrow.png"),
          color: Colors.white,
        )),
        title: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Color(0xff4E72D4),
      ),
      body: Container(
        child: Row(
          children: [
            RichText(
              text: TextSpan(
                text : "Please enter OTP send to",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: "+91 4654656256"
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
