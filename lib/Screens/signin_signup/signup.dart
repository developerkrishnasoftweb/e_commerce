import 'package:dio/dio.dart';
import 'package:e_commerce/Screens/signin_signup/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constant/strings.dart';
import '../../localization/localizations_constraints.dart';

import '../widgets/textinput.dart';
import '../../constant/color.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool terms = false;
  bool signUpStatus = false;
  String fullName = "", email = "", mobile = "", password = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 25,
                  splashRadius: 25,
                  onPressed: () {
                    // Navigator.pop(context);
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Let's Get Started!",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Color(0xff000000),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width,
                padding: const EdgeInsets.only(top: 5, bottom: 20),
                child: Text("Create an account on to use all the features",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Color(0xffA8A8A8),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              input(
                  context: context,
                  onChanged: (value) {
                    setState(() {
                      fullName = value;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  text: "Username"),
              input(
                  context: context,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  text: "Email"),
              input(
                  context: context,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      mobile = value;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  text: "Mobile No."),
              input(
                  context: context,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  onEditingComplete: _signUp,
                  obscureText: true,
                  text: "Password"),
              Container(
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                alignment: Alignment.centerLeft,
                child: CheckboxListTile(
                    value: terms,
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text("By signing up you agree to our terms and policy",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Color(0xffa8a8a8),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    onChanged: (value) {
                      setState(() {
                        terms = !terms;
                      });
                    }),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                  height: 50,
                  child: FlatButton(
                    child: Text("Sign Up"),
                    onPressed: !signUpStatus ? _signUp : null,
                    color: primaryColor,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: RichText(
                  text: TextSpan(
                      text:
                          "Already have an account?\t",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Color(0xffa8a8a8),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      children: [
                        WidgetSpan(
                            child: GestureDetector(
                          child: Text(
                            "SignIn",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                          },
                        ))
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signUp() async {
    FocusScope.of(context).unfocus();
    if (fullName != "" && email != "" && mobile != "" && password != "") {
      if (terms) {
        if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) {
          if (RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(mobile)) {

          } else {
            Fluttertoast.showToast(
                msg: "Invalid mobile number");
          }
        } else {
          Fluttertoast.showToast(
              msg: "Invalid email");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Please check terms and conditions");
      }
    } else {
      Fluttertoast.showToast(
          msg: "All fields are required");
    }
  }
}
