import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add Address",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            input(hintText: "Name"),
            input(hintText: "Mobile No"),
            input(hintText: "Pin Code *"),
            input(hintText: "Flat / House No *"),
            input(hintText: "Tower No."),
            input(hintText: "Building / Apartment Name"),
            input(hintText: "Address *"),
            input(hintText: "Landmark Area *"),
            input(hintText: "City, State"),
            Row(children: [
              Text("Save as"),
              ChoiceChip(label: Text("Home"), selected: false),
              ChoiceChip(label: Text("Work"), selected: true, onSelected: (value) {
                print(value);
              },),
              ChoiceChip(label: Text("Other"), selected: false),
            ],)
          ],
        ),
      ),
    );
  }

  Widget input(
      {String hintText,
      TextEditingController controller,
      ValueChanged<String> onChanged,
      VoidCallback onEditingComplete, TextInputAction textInputAction, TextInputType keyboardType, bool readOnly : false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType,
        readOnly: readOnly,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 16),
        ),
        cursorColor: Myapp.primaryColor,
      ),
    );
  }
}
