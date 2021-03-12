import 'package:e_commerce/Screens/my_addresses.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    if (widget.addressDetail != null) {
      name = TextEditingController(text: widget.addressDetail.name);
      mobile = TextEditingController(text: widget.addressDetail.mobileNo);
      address = TextEditingController(text: widget.addressDetail.address);
      pinCode = TextEditingController(text: widget.addressDetail.pinCode);
      state = TextEditingController(text: widget.addressDetail.state);
      city = TextEditingController(text: widget.addressDetail.city);
      setState(() => selectedIndex = option.indexOf(widget.addressDetail.type.toUpperCase()));
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
            toolbarHeight: 50.sp,
            title: Text(widget.addressDetail != null ? "Edit Address" : "Add Address",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            automaticallyImplyLeading: true),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              addAddressInputField(labelText: "Name *", controller: name),
              addAddressInputField(labelText: "Mobile No *", controller: mobile),
              addAddressInputField(labelText: "Address *", controller: address),
              addAddressInputField(labelText: "Pin Code *", controller: pinCode),
              addAddressInputField(labelText: "State *", controller: state),
              addAddressInputField(labelText: "City *", controller: city),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Save as", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                Row(
                    children: option.map((e) {
                  return Container(
                      margin: EdgeInsets.only(right: 5),
                      child: ChoiceChip(
                          label: Text(e, style: TextStyle(fontWeight: FontWeight.bold)),
                          selected: option.indexOf(e) == selectedIndex,
                          onSelected: (value) => setState(() => selectedIndex = option.indexOf(e)),
                          pressElevation: 1));
                }).toList())
              ]),
              SizedBox(height: 10),
              FlatButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                  child: Text(widget.addressDetail != null ? "Update Address" : "Save Address",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  height: 45,
                  minWidth: double.infinity,
                  color: Myapp.primaryColor)
            ])));
  }
}

Widget addAddressInputField(
    {String hintText,
    String labelText,
    TextEditingController controller,
    ValueChanged<String> onChanged,
    VoidCallback onEditingComplete,
    TextInputAction textInputAction,
    TextInputType keyboardType,
    double width,
    double height,
    GestureTapCallback onTap,
    EdgeInsetsGeometry margin,
    bool readOnly: false}) {
  return Container(
      height: height,
      width: width,
      margin: margin ?? EdgeInsets.only(bottom: 20),
      child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: keyboardType,
          readOnly: readOnly,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey, width: 2)),
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              labelText: labelText,
              hintText: hintText),
          cursorColor: Myapp.primaryColor));
}
