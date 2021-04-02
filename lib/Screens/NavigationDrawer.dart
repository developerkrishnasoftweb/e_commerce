import 'package:e_commerce/Screens/home/HomeScreen.dart';
import 'package:e_commerce/Screens/my_account.dart';
import 'package:e_commerce/Screens/signin_signup/signin.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'MyOrders.dart';
import 'ShopByCategoryScreen.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      userdata != null
          ? UserAccountsDrawerHeader(
              onDetailsPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyAccount()))
                    .then((value) => setState(() {}));
              },
              accountName: Text("${userdata.firstname} ${userdata.lastname}"),
              accountEmail: Text("${userdata.email}"),
              arrowColor: Myapp.primaryColor,
              currentAccountPicture:
                  Icon(Icons.account_circle, color: Colors.white, size: 60.sp))
          : UserAccountsDrawerHeader(
              accountName: Text("Login/SignIn",
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
              arrowColor: Myapp.primaryColor,
              onDetailsPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SignIn()))
                      .then((value) {
                    setState(() {});
                  })),
      createDrawerBodyItem(
          icon: Icons.home,
          text: 'Home',
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomeScreen()))),
      createDrawerBodyItem(
          icon: Icons.home,
          text: 'Shop by Category',
          onTap: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => ShopByCategoryScreen()))),
      createDrawerBodyItem(
          icon: Icons.person,
          text: 'My Orders',
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => MyOrders()))),
    ]));
  }
}

Widget createDrawerBodyItem(
        {IconData icon, String text, GestureTapCallback onTap}) =>
    ListTile(
        title: Row(children: <Widget>[
          //Icon(icon),
          Padding(padding: EdgeInsets.only(left: 8.0), child: Text(text))
        ]),
        onTap: onTap);
