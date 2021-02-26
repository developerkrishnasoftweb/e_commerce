import 'package:e_commerce/Screens/add_address.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String selectedGender = "gender";
  List<String> genders = ["gender", "male", "female", "other"];
  TextEditingController dob = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.sp,
            title: Text("Edit Profile", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)), automaticallyImplyLeading: true),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              input(
                  labelText: "First Name",
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus()),
              input(
                  labelText: "Last Name",
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus()),
              Row(children: [
                Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        margin: EdgeInsets.only(left: 2),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                        child: DropdownButton(
                            items: genders
                                .map((e) => DropdownMenuItem(
                                    child: Text(e.capitalize(), style: TextStyle(fontWeight: FontWeight.w500)), value: e))
                                .toList(),
                            value: selectedGender,
                            underline: SizedBox(),
                            isExpanded: true,
                            onChanged: (gender) => setState(() => selectedGender = gender)))),
                SizedBox(width: 10),
                Expanded(
                    child: input(
                        labelText: "Date Of Birth",
                        margin: EdgeInsets.zero,
                        keyboardType: TextInputType.datetime,
                        controller: dob,
                        onTap: () async {
                          DateTime date = DateTime.now();
                          FocusScope.of(context).requestFocus(new FocusNode());
                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime(DateTime.now().year),
                              firstDate: DateTime(DateTime.now().year - 100),
                              lastDate: DateTime(DateTime.now().year));
                          if (date != null)
                            dob.text = DateFormat('yyyy-M-d').format(date);
                        },
                        readOnly: true))
              ]),
              SizedBox(height: 10),
              input(
                  labelText: "Email",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () => FocusScope.of(context).nextFocus()),
              input(
                  labelText: "Mobile No",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  onEditingComplete: () => FocusScope.of(context).nextFocus()),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      child: Text("SAVE CHANGES", style: TextStyle(color: Colors.white)),
                      color: Myapp.primaryColor))
            ])));
  }
}

extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${this.substring(1)}";
}
