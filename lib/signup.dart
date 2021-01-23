import 'package:e_commerce/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class signup extends StatefulWidget {
  String get title => "";

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xff4E72D4),
        toolbarHeight: 100,
        leading: IconButton(
          icon: ImageIcon(
            AssetImage("assets/icons/left-arrow.png"),
            color: Colors.white,
          ),
        ),
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: new Column(
              children: <Widget>[
                SizedBox(height: 15,),
                TextField(
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: "Email Address",
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: "Password",
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: "Confirm Password",
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: "Mobile Number",
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  width: size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.lightBlue[100],
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: FlatButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OTP())),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                        "SIGNUP",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    color: Color(0xff4E72D4),
                  ),
                ),
                SizedBox(height: 15,),
                Text(
                    "Or with",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  width: size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.lightBlue[100],
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: FlatButton.icon(onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    icon: ImageIcon(
                      AssetImage("assets/icons/fb.png"),
                      color: Colors.white,
                    ),
                    label: RichText(
                      text: TextSpan(
                        text: "CONTINUE WITH ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffCBCBCB)
                        ),
                        children: [
                          TextSpan(
                            text: "FACEBOOK",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                                color: Colors.white
                            )
                          )
                        ]
                      ),

                    ),
                    color: Color(0xff3C5A99),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  width: size.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[500],
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: FlatButton.icon(onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    icon: Image.asset(
                      "assets/icons/google.png",
                    ),
                    label: RichText(
                      text: TextSpan(
                          text: "CONTINUE WITH ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xffCBCBCB)
                          ),
                          children: [
                            TextSpan(
                                text: "GOOGLE",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  color: Colors.black
                                )
                            )
                          ]
                      ),

                    ),
                    color: Color(0xffF8F8F8),
                  ),
                )
              ],

            ),
          ),
        ),
      ),
    );

  }
}
