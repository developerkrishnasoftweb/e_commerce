import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/my_addresses.dart';
import 'package:e_commerce/constant/color.dart';
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
  TextEditingController firstName = TextEditingController(),
      middleName = TextEditingController(),
      lastName = TextEditingController(),
      company = TextEditingController(),
      phoneNumber = TextEditingController(),
      street = TextEditingController(),
      city = TextEditingController(),
      state = TextEditingController(),
      pinCode = TextEditingController(),
      country = TextEditingController();
  String type;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.addressDetail != null) {
      // setState(() => selectedIndex = option.indexOf(widget.addressDetail.type.toUpperCase()));
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
            child: Form(
              key: formKey,
              child: Column(children: [
                addAddressInputField(
                    labelText: "First Name *",
                    controller: firstName,
                    validator: validate),
                addAddressInputField(
                    labelText: "Middle Name", controller: middleName),
                addAddressInputField(
                    labelText: "Last Name *", controller: lastName, validator: validate),
                addAddressInputField(labelText: "Company", controller: company),
                addAddressInputField(
                    labelText: "Phone Number *", controller: phoneNumber, validator: validate),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("ADDRESS",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    )),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                  indent: 7,
                  endIndent: 7,
                ),
                SizedBox(height: 20),
                addAddressInputField(labelText: "Street *", controller: street, validator: validate),
                addAddressInputField(labelText: "City *", controller: city, validator: validate),
                addAddressInputField(
                    labelText: "State/Province *", controller: state, validator: validate),
                addAddressInputField(
                    labelText: "Zip/Postal Code *", controller: pinCode, validator: validate),
                addAddressInputField(
                    labelText: "Country *", controller: country, validator: validate),
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
              ]),
            )));
  }

  void addAddress() async {
    print(formKey.currentState.validate());
    Map<String, dynamic> bodyData = {};
    ResponseData responseData = await ApiService.generateToken(
        {"username": "i@gmail.com", "password": "Abc@123456"});
    ResponseData addressResponseData =
        await ApiService.addAddress(token: responseData.token, body: bodyData);
  }

  String validate(String value) {
    if (value.isNotEmpty)
      return null;
    else
      return "This is required field";
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
    FormFieldValidator<String> validator,
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
          validator: validator,
          keyboardType: keyboardType,
          readOnly: readOnly,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              labelText: labelText,
              hintText: hintText),
          cursorColor: Myapp.primaryColor));
}
