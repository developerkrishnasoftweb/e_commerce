import 'package:e_commerce/Screens/HomeScreen.dart';
import 'package:e_commerce/Screens/my_account.dart';
import 'package:e_commerce/UI/Homepage.dart';
import 'package:e_commerce/UI/login.dart';
import 'package:e_commerce/UI/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ShopByCategoryScreen.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      UserAccountsDrawerHeader(
        accountName: Text("Ashish Rawat"),
        accountEmail: Text("ashishrawat2911@gmail.com"),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.grey[350]
              : Colors.white,
          child: Text(
            "A",
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),

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
          icon: Icons.login,
          text: 'Login/SignIn',
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LogIn()))),
      createDrawerBodyItem(
          icon: Icons.person,
          text: 'My Account',
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => MyAccount()))),
      createDrawerBodyItem(
          icon: Icons.logout,
          text: 'Logout',
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => signup()))),
      // createDrawerBodyItem(
      //   icon: Icons.account_circle,
      //   text: 'Profile',
      //   onTap: () =>
      //       Navigator.pushReplacementNamed(context, pageRoutes.profile),
      // ),
      //
      // createDrawerBodyItem(
      //   icon: Icons.event_note,
      //   text: 'Events',
      //   onTap: () =>
      //       Navigator.pushReplacementNamed(context, pageRoutes.event),
      // ),
      // Divider(),
      // createDrawerBodyItem(
      //   icon: Icons.notifications_active,
      //   text: 'Notifications',
      //   onTap: () =>
      //       Navigator.pushReplacementNamed(context, pageRoutes.notification),
      // ),
      // createDrawerBodyItem(
      //   icon: Icons.contact_phone,
      //   text: 'Contact Info',
      //   onTap: () =>
      //       Navigator.pushReplacementNamed(context, pageRoutes.contact),
      // ),
      ListTile(title: Text('App version 1.0.0'), onTap: () {})
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
