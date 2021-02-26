import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../widgets/textinput.dart';
import '../../constant/color.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool terms = false, isLoading = false;
  List<String> genders = ["Select Gender", "Male", "Female", "Not Specified"];
  int gender = 0;
  String firstName = "", lastName = "", email = "", password = "";
  TextEditingController dob = TextEditingController();

  setLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

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
                    Navigator.pop(context);
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
                child: Text(
                  "Create an account on to use all the features",
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
                      firstName = value;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  text: "First name $mandatoryChar"),
              input(
                  context: context,
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  text: "Last name $mandatoryChar"),
              input(
                  context: context,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  text: "Email $mandatoryChar"),
              input(
                  context: context,
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    DateTime date = DateTime.now();
                    FocusScope.of(context).requestFocus(new FocusNode());
                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(DateTime.now().year),
                        firstDate: DateTime(DateTime.now().year - 100),
                        lastDate: DateTime(DateTime.now().year));
                    if (date != null)
                      dob.text = DateFormat('yyyy-M-d').format(date);
                  },
                  controller: dob,
                  textInputAction: TextInputAction.next,
                  text: "Date Of Birth $mandatoryChar"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gender",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Container(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey)),
                        child: DropdownButton(
                            value: gender,
                            isExpanded: true,
                            items: genders.map((e) {
                              return DropdownMenuItem(
                                  child: Text(e.toUpperCase()),
                                  value: genders.indexOf(e));
                            }).toList(),
                            underline: SizedBox(),
                            onChanged: (v) {
                              setState(() {
                                gender = v;
                              });
                            })),
                  ],
                ),
              ),
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
                    title: Text(
                      "By signing up you agree to our terms and policy",
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
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: FlatButton(
                    child: isLoading
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          )
                        : Text("Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    onPressed: !isLoading ? _signUp : null,
                    color: primaryColor,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: RichText(
                  text: TextSpan(
                      text: "Already have an account?\t",
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
                            Navigator.pop(context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
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
    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        dob.text.isNotEmpty &&
        gender != 0 &&
        password.isNotEmpty) {
      if (terms) {
        if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) {
          setLoading(true);
          Map<String, dynamic> body = {
            "customer": {
              "email": email,
              "firstname": firstName,
              "lastname": lastName,
              "dob": dob.text,
              "gender": gender
            },
            "password": password
          };
          await ApiService.register(body).then((value) {
            if (value.status) {
              Fluttertoast.showToast(msg: value.message);
              setLoading(true);
              Navigator.pop(context, email);
            } else {
              Fluttertoast.showToast(
                  msg: value.message, toastLength: Toast.LENGTH_LONG);
              setLoading(false);
            }
          });
          setLoading(false);
          // if (RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(mobile)) {
          // } else {
          //   Fluttertoast.showToast(msg: "Invalid mobile number");
          // }
        } else {
          Fluttertoast.showToast(msg: "Invalid email");
        }
      } else {
        Fluttertoast.showToast(msg: "Please check terms and conditions");
      }
    } else {
      Fluttertoast.showToast(msg: "All fields are required");
    }
  }
}
