import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  int selectedIndex;
  List<String> option = ['Home', 'Work', 'Other'];
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Save as",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Row(
                children: option.map((e) {
                  return Container(
                    margin: EdgeInsets.only(right: 5),
                    child: ChoiceChip(
                        label: Text(e,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        selected: option.indexOf(e) == selectedIndex,
                        onSelected: (value) {
                          setState(() {
                            selectedIndex = option.indexOf(e);
                          });
                        },
                        pressElevation: 1),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(height: 10),
            FlatButton(
              onPressed: () {},
              child: Text("Save Address", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
              height: 50,
              minWidth: double.infinity,
              color: Myapp.primaryColor
            )
          ],
        ),
      ),
    );
  }

  Widget input(
      {String hintText,
      TextEditingController controller,
      ValueChanged<String> onChanged,
      VoidCallback onEditingComplete,
      TextInputAction textInputAction,
      TextInputType keyboardType,
      bool readOnly: false}) {
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
            borderSide: BorderSide(color: Colors.grey, width: 2),
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
