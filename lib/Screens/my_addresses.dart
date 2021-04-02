import 'dart:convert';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/add_address.dart';
import 'package:e_commerce/constant/color.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAddress extends StatefulWidget {
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  List<Addresses> addresses = [];
  bool isDeletingAddress = false;

  setDelete(bool status) {
    setState(() {
      isDeletingAddress = status;
    });
  }

  @override
  void initState() {
    super.initState();
    getAddresses();
  }

  getAddresses() async {
    addresses.clear();
    setState(() {
      addresses = UserDetails.fromJson(
              jsonDecode(sharedPreferences.getString(Preferences.user)))
          .addresses;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text("Address",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            automaticallyImplyLeading: true),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton.icon(
                  minWidth: double.infinity,
                  onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddAddress()))
                      .then((value) => getAddresses()),
                  height: 55,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: BorderSide(color: Colors.grey[500], width: 2)),
                  icon: Icon(Icons.add, color: Myapp.primaryColor),
                  label: Text("Add New Address",
                      style: TextStyle(
                          color: Myapp.primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)))),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (_, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 3),
                        padding: EdgeInsets.all(10),
                        height: 180,
                        width: size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(children: [
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${addresses[index].firstname}" +
                                          ' ' +
                                          "${addresses[index].lastname}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  SizedBox(height: 5),
                                  Text("${addresses[index].street[0]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Text(
                                      "${addresses[index].city} - ${addresses[index].postcode}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Text("${addresses[index].region.region}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Text("${addresses[index].telephone}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.grey))
                                ]),
                          )),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Spacer(),
                              FlatButton(
                                  child: Text("Modify",
                                      style:
                                          TextStyle(color: Myapp.primaryColor)),
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddAddress(
                                              addressDetail:
                                                  addresses[index]))).then((value) {
                                                    getAddresses();
                                  })),
                              FlatButton(
                                  child: !isDeletingAddress
                                      ? Text("Delete",
                                          style:
                                              TextStyle(color: Colors.black87))
                                      : SizedBox(
                                          child: CircularProgressIndicator(),
                                          height: 25,
                                          width: 25,
                                        ),
                                  onPressed: !isDeletingAddress
                                      ? () => deleteAddress(
                                          addresses[index].id.toString())
                                      : null),
                            ],
                          ),
                        ]));
                  },
                  itemCount: addresses.length,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: BouncingScrollPhysics()))
        ]));
  }

  void deleteAddress(String addressId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Address"),
            content:
                Text("Are you sure you really want to delete this address?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("NO", style: TextStyle(color: Colors.grey))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    removeAddress(addressId);
                  },
                  child: Text("YES", style: TextStyle(color: primaryColor))),
            ],
          );
        });
  }

  void removeAddress(String addressId) async {
    setDelete(true);
    await ApiService.generateToken(
            {"username": userdata.email, "password": userdata.password})
        .then((tokenResponse) async {
          print(tokenResponse.token);
      if (tokenResponse.status) {
        await ApiService.removeAddress(
                token: tokenResponse.token, addressId: addressId)
            .then((addressResponse) async {
          if (addressResponse.status) {
            await ApiService.login(tokenResponse.token).then((loginResponse) {
              if (loginResponse.status) {
                sharedPreferences.setString(
                    Preferences.user,
                    jsonEncode(UserDetails.fromJson(loginResponse.data)
                      ..password = userdata.password
                      ..toJson()));
                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(msg: loginResponse.message);
              }
            });
          } else {
            Fluttertoast.showToast(msg: addressResponse.message);
          }
        });
      } else {
        Fluttertoast.showToast(msg: tokenResponse.message);
      }
    });
    setDelete(false);
  }
}
