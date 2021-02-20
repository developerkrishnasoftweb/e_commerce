import 'package:e_commerce/Screens/my_addresses.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  final AddressDetail addressDetail;

  const AddAddress({Key key, this.addressDetail}) : super(key: key);
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  int selectedIndex;
  List<String> option = ['HOME', 'WORK', 'OTHER'];
  TextEditingController name, mobile, address, pinCode, state, city;
  String type;

  @override
  void initState() {
    super.initState();
    if(widget.addressDetail != null) {
      name = TextEditingController(text: widget.addressDetail.name);
      mobile = TextEditingController(text: widget.addressDetail.mobileNo);
      address = TextEditingController(text: widget.addressDetail.address);
      pinCode = TextEditingController(text: widget.addressDetail.pinCode);
      state = TextEditingController(text: widget.addressDetail.state);
      city = TextEditingController(text: widget.addressDetail.city);
      setState(() {
        selectedIndex = option.indexOf(widget.addressDetail.type.toUpperCase());
      });
    } else {
      name = TextEditingController();
      mobile = TextEditingController();
      address = TextEditingController();
      pinCode = TextEditingController();
      state = TextEditingController();
      city = TextEditingController();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.addressDetail != null ? "Edit Address" : "Add Address",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            input(hintText: "Name *", controller: name),
            input(hintText: "Mobile No *", controller: mobile),
            input(hintText: "Address *", controller: address),
            input(hintText: "Pin Code *", controller: pinCode),
            input(hintText: "State *", controller: state),
            input(hintText: "City *", controller: city),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
                ),
              child: Text(widget.addressDetail != null ? "Update Address" : "Save Address", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
              height: 45,
              minWidth: double.infinity,
              color: Myapp.primaryColor
            )
          ],
        ),
      ),
    );
  }
}

Widget input(
    {String hintText,
      TextEditingController controller,
      ValueChanged<String> onChanged,
      VoidCallback onEditingComplete,
      TextInputAction textInputAction,
      TextInputType keyboardType,
      double width,
      double height,
      bool readOnly: false}) {
  return Container(
    height: height,
    width: width,
    margin: EdgeInsets.only(bottom: 20),
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType,
      readOnly: readOnly,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        hintText: hintText,
      ),
      cursorColor: Myapp.primaryColor,
    ),
  );
}