import 'dart:convert';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Screens/my_addresses.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NavigationDrawer.dart';
import 'edit_profile.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  String email = '';
  String fname = '';
  String lname = '';

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      setState(() {
        Map userMap = jsonDecode(pref.getString(Preferences.user));
        UserDetails user = UserDetails.fromJson(userMap);
        email = user.email ?? '';
        fname = user.firstname ?? '';
        lname = user.lastname ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.sp, title: Text("My Account", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold))),
        drawer: navigationDrawer(),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              height: 250,
              width: size.width,
              color: Myapp.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(children: [
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(70)),
                          child: Icon(Icons.person, color: Myapp.primaryColor, size: 30)),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(fname + ' ' + lname,
                                        style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 3),
                                    Text(email,
                                        style: TextStyle(fontSize: 13, color: Colors.white60, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 3),
                                    Text("+91-8758431417",
                                        style: TextStyle(fontSize: 13, color: Colors.white60, fontWeight: FontWeight.bold))
                                  ]))),
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile())),
                          color: Colors.white)
                    ])),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(children: [
                          Expanded(
                              child: Row(children: [
                            profileButton(onPressed: () {}, icon: Icons.credit_card_outlined, label: "Payment Methods"),
                            SizedBox(width: 10),
                            profileButton(onPressed: () {}, icon: Icons.history, label: "Order History")
                          ])),
                          SizedBox(height: 10),
                          profileButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyAddress())),
                              icon: Icons.location_on_rounded,
                              label: "Delivery Address")
                        ])))
              ])),
          ListTile(title: Text("My List", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)), onTap: () {}),
          Divider(height: 0, color: Colors.grey),
          ListTile(title: Text("Contact Us", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)), onTap: () {}),
          Divider(height: 0, color: Colors.grey),
          ListTile(
              title: Text("Logout", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              onTap: () {
                SharedPreferences.getInstance().then((pref) {
                  pref.clear();
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              }),
          Divider(height: 0, color: Colors.grey)
        ])));
  }

  Widget profileButton({IconData icon, String label, @required VoidCallback onPressed}) {
    return Expanded(
        child: FlatButton(
            height: double.infinity,
            onPressed: onPressed,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: Colors.white38,
            child: Row(children: [
              Icon(icon, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Expanded(
                  child: Text(label,
                      style: TextStyle(color: Colors.white, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis))
            ])));
  }
}
