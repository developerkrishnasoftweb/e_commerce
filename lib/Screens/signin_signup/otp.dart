
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constant/color.dart';

class OTP extends StatefulWidget {
  final String otp, mobile;
  final FormData formData;
  OTP({
    this.otp,
    this.formData,
    this.mobile
  });
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  FocusNode textFocusNode = new FocusNode();
  String otp = "";
  bool isLoading = false;
  setLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: appBar(context: context, title: "Enter OTP"),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "We have sent OTP ${widget.mobile != null ? "***" + widget.mobile.substring(6) : "."}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            width: size.width,
          ),
          Image(
            image: AssetImage("assets/images/message.png"),
            height: 200,
            width: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < 4; i++) ...[
                    buildOtpTextField(i),
                  ]
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
      floatingActionButton: Container(
          width: double.infinity,
          height: 50,
          child: FlatButton(
            child: Text("SUBMIT"),
            onPressed: isLoading
                ? null
                : _action,
            color: primaryColor,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _action() {
    if (widget.otp == this.otp) {

    } else {
      Fluttertoast.showToast(msg: "Invalid OTP");
    }
  }

  Widget buildOtpTextField(int pos) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            contentPadding: EdgeInsets.all(10)),
        keyboardType: TextInputType.number,
        maxLength: 1,
        buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
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
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
