import 'dart:convert';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Screens/add_address.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAddress extends StatefulWidget {
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  List<Addresses> addresses = [];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      Map userMap = jsonDecode(pref.getString(Preferences.user));
      addresses = UserDetails.fromJson(userMap).addresses;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text("Address", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            automaticallyImplyLeading: true),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton.icon(
                  minWidth: double.infinity,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress())),
                  height: 55,
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7), side: BorderSide(color: Colors.grey[500], width: 2)),
                  icon: Icon(Icons.add, color: Myapp.primaryColor),
                  label: Text("Add New Address", style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold)))),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (_, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 3),
                        padding: EdgeInsets.all(10),
                        height: 180,
                        width: size.width,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2), borderRadius: BorderRadius.circular(7)),
                        child: Column(children: [
                          Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(addresses[index].firstname + ' ' + addresses[index].lastname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                  SizedBox(height: 5),
                                  Text("${addresses[index].street[0]}",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Text("${addresses[index].city} - ${addresses[index].postcode}",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Text(addresses[index].region.region,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Text(addresses[index].telephone,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey))
                                ])),
                                Container(
                                    padding: EdgeInsets.all(4),
                                    child: Text('home'.toUpperCase(),
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey[300]))
                              ])),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: FlatButton(
                                  child: Text("Modify", style: TextStyle(color: Myapp.primaryColor)),
                                  onPressed: () => Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => AddAddress(addressDetail: addresses[index])))))
                        ]));
                  },
                  itemCount: addresses.length,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: BouncingScrollPhysics()))
        ]));
  }
}
