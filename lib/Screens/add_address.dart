import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/my_addresses.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAddress extends StatefulWidget {
  final Addresses addressDetail;

  const AddAddress({Key key, this.addressDetail}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  int selectedIndex;
  List<String> option = ['HOME', 'WORK', 'OTHER'];
  TextEditingController firstName,
      lastName,
      company,
      mobile,
      address,
      pinCode,
      state,
      city,
      country;
  String type;

  @override
  void initState() {
    super.initState();
    if (widget.addressDetail != null) {
      // setState(() => selectedIndex = option.indexOf(widget.addressDetail.type.toUpperCase()));
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text(
                widget.addressDetail != null ? "Edit Address" : "Add Address",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            automaticallyImplyLeading: true),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              addAddressInputField(labelText: "First Name *", controller: firstName),
              addAddressInputField(labelText: "Last Name *", controller: lastName),
              addAddressInputField(labelText: "Company", controller: lastName),
              addAddressInputField(
                  labelText: "Mobile No *", controller: mobile),
              addAddressInputField(labelText: "Street *", controller: address),
              addAddressInputField(labelText: "City *", controller: city),
              addAddressInputField(
                  labelText: "Pin Code *", controller: pinCode),
              addAddressInputField(labelText: "State *", controller: state),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Save as",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                Row(
                    children: option.map((e) {
                  return Container(
                      margin: EdgeInsets.only(right: 5),
                      child: ChoiceChip(
                          label: Text(e,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          selected: option.indexOf(e) == selectedIndex,
                          onSelected: (value) =>
                              setState(() => selectedIndex = option.indexOf(e)),
                          pressElevation: 1));
                }).toList())
              ]),
              SizedBox(height: 10),
              FlatButton(
                  onPressed: addAddress,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  child: Text(
                      widget.addressDetail != null
                          ? "Update Address"
                          : "Save Address",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  height: 45,
                  minWidth: double.infinity,
                  color: Myapp.primaryColor)
            ])));
  }

  void addAddress() async {
    if (firstName.text.isNotEmpty &&
        mobile.text.isNotEmpty &&
        address.text.isNotEmpty &&
        pinCode.text.isNotEmpty &&
        state.text.isNotEmpty &&
        city.text.isNotEmpty) {
      Map<String, dynamic> bodyData = {
        "customer": {
          "firstname": "Rohan",
          "lastname": "Hapani",
          "website_id": 1,
          "addresses": [
            {
              "region": {
                "region_code": "PB",
                "region": "PUNJAB",
                "region_id": 43
              },
              "country_id": "IN",
              "street": ["Add", "Add2"],
              "firstname": "Rohan",
              "lastname": "Hapani",
              "default_shipping": true,
              "default_billing": true,
              "telephone": "1234567890",
              "postcode": "98761",
              "city": "New York"
            },
            {
              "region": {
                "region_code": "NY",
                "region": "New York",
                "region_id": 43
              },
              "country_id": "US",
              "street": ["Add3", "Add4"],
              "firstname": "Rohan",
              "lastname": "Hapani",
              "defaultShipping": false,
              "defaultBilling": false,
              "telephone": "9876543210",
              "postcode": "10755",
              "city": "New York"
            }
          ]
        }
      };
      ResponseData responseData = await ApiService.generateToken(
          {"username": "i@gmail.com", "password": "Abc@123456"});
      ResponseData addressResponseData = await ApiService.addAddress(
          token: responseData.token, body: bodyData);
    }
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
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey, width: 2)),
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              labelText: labelText,
              hintText: hintText),
          cursorColor: Myapp.primaryColor));
}
