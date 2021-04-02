import 'dart:convert';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Screens/home/HomeScreen.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(Myapp());
  await getUserData();
}

Future<void> getUserData() async {
  var user = sharedPreferences.getString(Preferences.user);
  if(user != null) {
    userdata = UserDetails.fromJson(jsonDecode(user));
  }
}

class Myapp extends StatefulWidget {
  static Color primaryColor = Color(0xffeb3434);

  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        allowFontScaling: false,
        builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
            // home: Category(title: "Saree",),
            theme: ThemeData(
                // fontFamily: "Segoe UI"
                accentColor: Myapp.primaryColor,
                primaryColor: Myapp.primaryColor)));
  }
}
