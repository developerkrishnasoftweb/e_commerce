import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/constant/models.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color.dart';
import '../../constant/global.dart';
import '../widgets/textinput.dart';
import 'forgot_password.dart';
import 'signup.dart';

class SignIn extends StatefulWidget {
  final String email;

  SignIn({this.email});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  String password = "", token = "";
  TextEditingController emailController = TextEditingController();
  FocusNode myFocusNode;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  setLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  @override
  void initState() {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    setState(() {
      emailController.text = widget.email ?? "";
      userdata = null;
    });
    myFocusNode = FocusNode();
    if (widget.email != null) {
      myFocusNode.requestFocus();
    }
    firebaseCloudMessagingListeners();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  void firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) iOSPermission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
    await _firebaseMessaging.subscribeToTopic('all');
    await _firebaseMessaging.getToken().then((token) {
      setState(() {
        this.token = token;
      });
    });
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails('channel_id', 'CHANNEL NAME', 'channelDescription');
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.show(
        Random().nextInt(100), msg["notification"]["title"], msg["notification"]["body"], platform);
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/login_register_background.png"),
              fit: BoxFit.fill,
            )),
            child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 30, left: 20, right: 20),
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  Image(
                    image: AssetImage("assets/images/pal-logo.png"),
                    height: 280,
                    width: 350,
                    fit: BoxFit.fill,
                  ),
                  input(
                      context: context,
                      style: TextStyle(fontSize: 17),
                      text: "Username",
                      autoFocus: true,
                      keyboardType: TextInputType.emailAddress,
                      onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      controller: emailController),
                  input(
                      context: context,
                      style: TextStyle(fontSize: 17),
                      text: "Password",
                      obscureText: true,
                      onEditingComplete: _signIn,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      focusNode: myFocusNode),
                  Align(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Forgot Password?",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                    alignment: Alignment.centerRight,
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
                            : Text("Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        onPressed: !isLoading ? _signIn : null,
                        color: primaryColor,
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: RichText(
                          text: TextSpan(
                              text: "Don't have an account?\t",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Color(0xffa8a8a8), fontSize: 16, fontWeight: FontWeight.bold),
                              children: [
                            WidgetSpan(
                                child: GestureDetector(
                                    child: Text(
                                      "SignUp",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())).then((value) {
                                        setState(() {
                                          emailController.text = value;
                                        });
                                      });
                                    }))
                          ])))
                ]))));
  }

  void _signIn() async {
    FocusScope.of(context).unfocus();
    if (emailController.text.isNotEmpty && password.isNotEmpty) {
      setLoading(true);
      if (token.isEmpty) firebaseCloudMessagingListeners();
      Map<String, dynamic> body = {"username": emailController.text, "password": password};
      await ApiService.generateToken(body).then((value) async {
        if (value.status) {
          Map<String, dynamic> map = value.data;
          setLoading(false);
          Fluttertoast.showToast(msg: value.message);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(Preferences.isLogin, true);
          prefs.setString(Preferences.user, jsonEncode(UserDetails.fromJson(map)..password = password..toJson()));
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          setLoading(false);
          Fluttertoast.showToast(msg: value.message, toastLength: Toast.LENGTH_LONG);
        }
      });
      setLoading(false);
    } else {
      Fluttertoast.showToast(msg: "Please enter username and password");
    }
  }
}
