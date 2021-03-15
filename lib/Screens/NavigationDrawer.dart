import 'dart:convert';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Screens/home/HomeScreen.dart';
import 'package:e_commerce/Screens/my_account.dart';
import 'package:e_commerce/Screens/signin_signup/signin.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyOrders.dart';
import 'ShopByCategoryScreen.dart';

class navigationDrawer extends StatefulWidget {
  @override
  _navigationDrawerState createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  bool isLogin = false;
  String email = '';
  String fname = '';
  String lname = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      setState(() {
        isLogin = pref.getBool(Preferences.isLogin) ?? false;
        if (isLogin) {
          Map userMap = jsonDecode(pref.getString(Preferences.user));
          UserDetails user = UserDetails.fromJson(userMap);
          email = user.email ?? '';
          fname = user.firstname ?? '';
          lname = user.lastname ?? '';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      isLogin
          ? UserAccountsDrawerHeader(
              onDetailsPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MyAccount())),
              accountName: Text(fname + ' ' + lname),
              accountEmail: Text(email),
              arrowColor: Myapp.primaryColor,
              currentAccountPicture: Icon(Icons.account_circle, color: Colors.white, size: 60.sp))
          : UserAccountsDrawerHeader(
              accountName: Text("Login/SignIn", style: TextStyle(fontSize: 20.0, color: Colors.white)),
              arrowColor: Myapp.primaryColor,
              onDetailsPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn()))),
      createDrawerBodyItem(
          icon: Icons.home,
          text: 'Home',
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()))),
      createDrawerBodyItem(
          icon: Icons.home,
          text: 'Shop by Category',
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ShopByCategoryScreen()))),
      createDrawerBodyItem(
          icon: Icons.person,
          text: 'My Orders',
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyOrders()))),
      ListTile(title: Text('App version 1.0.0'), onTap: () {})
    ]));
  }
}

Widget createDrawerBodyItem({IconData icon, String text, GestureTapCallback onTap}) => ListTile(
    title: Row(children: <Widget>[
      //Icon(icon),
      Padding(padding: EdgeInsets.only(left: 8.0), child: Text(text))
    ]),
    onTap: onTap);
