import 'dart:convert';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Screens/add_address.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/textinput.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String selectedGender = "gender";
  List<String> genders = ["gender", "male", "female", "other"];
  TextEditingController fnameController,
      lnameController,
      emailController,
      dobController,
      mobile,
      address,
      pinCode,
      state,
      city;

  String email = '';
  String fname = '';
  String dob = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dobController = TextEditingController();

    SharedPreferences.getInstance().then((pref) {
      setState(() {
        Map userMap = jsonDecode(pref.getString(Preferences.user));
        UserDetails user = UserDetails.fromJson(userMap);
        dob = user.dob ?? '';
        fnameController = TextEditingController(text: user.firstname ?? '');
        lnameController = TextEditingController(text: user.lastname ?? '');
        emailController = TextEditingController(text: user.email ?? '');
        dobController = TextEditingController(text: dob);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text("Edit Profile",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            automaticallyImplyLeading: true),
        body: SingleChildScrollView(
            child: Column(children: [
              input(
                  text: "First Name",
                  controller: fnameController,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus()),
              input(
                  text: "Last Name",
                  controller: lnameController,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus()),
              Row(children: [
                Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        margin: EdgeInsets.only(left: 2),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 1))),
                        child: DropdownButton(
                            items: genders
                                .map((e) => DropdownMenuItem(
                                    child: Text(e.capitalize(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    value: e))
                                .toList(),
                            value: selectedGender,
                            underline: SizedBox(),
                            isExpanded: true,
                            onChanged: (gender) =>
                                setState(() => selectedGender = gender)))),
                SizedBox(width: 10),
                Expanded(
                    child: input(
                        text: "Date Of Birth",
                        margin: EdgeInsets.zero,
                        keyboardType: TextInputType.datetime,
                        controller: dobController,
                        onTap: () async {
                          DateTime date = dob.isNotEmpty
                              ? DateTime.parse(dob)
                              : DateTime.now();
                          FocusScope.of(context).requestFocus(new FocusNode());
                          date = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(DateTime.now().year - 100),
                              lastDate: DateTime.now());
                          if (date != null)
                            dobController.text =
                                DateFormat('yyyy-MM-dd').format(date);
                        },
                        readOnly: true))
              ]),
              SizedBox(height: 10),
              input(
                  text: "Email",
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () => FocusScope.of(context).nextFocus()),
              input(
                  text: "Mobile No",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  onEditingComplete: () => FocusScope.of(context).nextFocus()),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: Text("SAVE CHANGES",
                          style: TextStyle(color: Colors.white)),
                      color: Myapp.primaryColor))
            ])));
  }
}

extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${this.substring(1)}";
}
