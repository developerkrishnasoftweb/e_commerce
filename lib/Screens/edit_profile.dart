import 'package:e_commerce/Screens/add_address.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Address",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: input(hintText: "First Name")),
                SizedBox(width: 10,),
                Expanded(child: input(hintText: "Last Name")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
