import 'dart:convert';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Models/countries_model.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/home/widgets/custom_dropdown.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddress extends StatefulWidget {
  final Addresses addressDetail;

  const AddAddress({Key key, this.addressDetail}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController firstName = TextEditingController(),
      lastName = TextEditingController(),
      email = TextEditingController(),
      phoneNumber = TextEditingController(),
      street = TextEditingController(),
      street1 = TextEditingController(),
      city = TextEditingController(),
      state = TextEditingController(),
      pinCode = TextEditingController(),
      country = TextEditingController();
  String type;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Countries> countries = [];
  Countries selectedCountry;
  Regions selectedRegion;
  UserDetails userDetails;

  @override
  void initState() {
    super.initState();
    if (widget.addressDetail != null) {
      firstName.text = widget.addressDetail.firstname;
      lastName.text = widget.addressDetail.lastname;
      // email.text = widget.addressDetail;
      phoneNumber.text = widget.addressDetail.telephone;
      street.text = widget.addressDetail.street[0];
      street1.text = widget.addressDetail.street[1];
      city.text = widget.addressDetail.city;
      // selectedRegion = Regions(
      //     name: widget.addressDetail.region.region,
      //     code: widget.addressDetail.region.regionCode,
      //     id: widget.addressDetail.region.regionId.toString());
      pinCode.text = widget.addressDetail.postcode;
    }
    getCountries();
    getUser();
  }

  getUser() async {
    await SharedPreferences.getInstance().then((pref) {
      Map userMap = jsonDecode(pref.getString(Preferences.user));
      setState(() {
        userDetails = UserDetails.fromJson(userMap);
      });
    });
  }

  getCountries() async {
    List<Countries> tempCountries = await ApiService.getCountries();
    setState(() {
      countries = tempCountries;
      selectedCountry = countries.where((element) => element.id == "IN").first;
    });
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
                    labelText: "Last Name *",
                    controller: lastName,
                    validator: validate),
                addAddressInputField(labelText: "Email *", controller: email),
                addAddressInputField(
                    labelText: "Phone Number *",
                    controller: phoneNumber,
                    validator: validate),
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
                addAddressInputField(
                    labelText: "Street 1 *",
                    controller: street,
                    validator: validate),
                addAddressInputField(
                    labelText: "Street 2 *",
                    controller: street1,
                    validator: validate),
                addAddressInputField(
                    labelText: "City *", controller: city, validator: validate),
                selectedCountry?.availableRegions != null
                    ? selectedCountry.availableRegions.length > 0
                        ? dropDown<Regions>(
                            value: selectedRegion,
                            margin: EdgeInsets.only(bottom: 20),
                            items: selectedCountry.availableRegions
                                .map((region) => DropdownMenuItem<Regions>(
                                    child: Text(region.name), value: region))
                                .toList(),
                            label: "State/Province *",
                            onChanged: (region) {
                              setState(() {
                                selectedRegion = region;
                              });
                            })
                        : addAddressInputField(
                            labelText: "State/Province *",
                            controller: state,
                            readOnly: selectedCountry != null
                                ? !(selectedCountry.id == "IN")
                                : false,
                            validator: validate)
                    : addAddressInputField(
                        labelText: "State/Province *",
                        controller: state,
                        readOnly: selectedCountry != null
                            ? !(selectedCountry.id == "IN")
                            : false,
                        validator: validate),
                addAddressInputField(
                    labelText: "Zip/Postal Code *",
                    controller: pinCode,
                    validator: validate),
                countries.length > 0
                    ? dropDown<Countries>(
                        margin: EdgeInsets.only(bottom: 20),
                        onChanged: (Countries country) {
                          setState(() {
                            selectedCountry = country;
                          });
                        },
                        label: "Country *",
                        items: countries
                            .map((country) => DropdownMenuItem<Countries>(
                                child: Text("${country.fullNameEnglish}"),
                                value: country))
                            .toList(),
                        value: selectedCountry)
                    : addAddressInputField(
                        labelText: "Country *",
                        controller: country,
                        validator: validate),
                FlatButton(
                    onPressed: widget.addressDetail != null
                        ? updateAddress
                        : addAddress,
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

  void updateAddress() async {
    Map<String, dynamic> bodyData = {
      "customer": {
        "email": email.text,
        "firstname": firstName.text,
        "lastname": lastName.text,
        "dob": userDetails.dob,
        "gender": userDetails.gender,
        "website_id": userDetails.websiteId,
        "addresses": [
          {
            "region": {
              "region_code": selectedRegion.code,
              "region": selectedRegion.name,
              "region_id": selectedRegion.id
            },
            "country_id": selectedCountry.id,
            "street": [street.text, street1.text],
            "firstname": firstName.text,
            "lastname": lastName.text,
            "default_shipping": true,
            "default_billing": true,
            "telephone": phoneNumber.text,
            "postcode": pinCode.text,
            "city": city.text
          }
        ]
      }
    };
    await ApiService.generateToken(
            {"username": userDetails.email, "password": "Abc@123456"},
            getOnlyToken: true)
        .then((value) async {
      if (value.status) {
        await ApiService.updateAddress(body: bodyData, token: value.token, addressId: widget.addressDetail.id.toString()).then((value) {
          if(value.status) {
            Fluttertoast.showToast(msg: value.message);
          } else {
            Fluttertoast.showToast(msg: value.message);
          }
        });
      } else {
        Fluttertoast.showToast(msg: value.message);
      }
    });
  }

  void addAddress() async {
    if (formKey.currentState.validate()) {
      if (selectedRegion == null && selectedCountry == null) {
        Fluttertoast.showToast(msg: "All fields are required");
        return;
      }
      Map<String, dynamic> bodyData = {
        "customer": {
          "email": email.text,
          "firstname": firstName.text,
          "lastname": lastName.text,
          "dob": userDetails.dob,
          "gender": userDetails.gender,
          "website_id": 1,
          "addresses": [
            {
              "region": {
                "region_code": selectedRegion.code,
                "region": selectedRegion.name,
                "region_id": selectedRegion.id
              },
              "country_id": selectedCountry.id,
              "street": [street.text, street1.text],
              "firstname": firstName.text,
              "lastname": lastName.text,
              "default_shipping": true,
              "default_billing": true,
              "telephone": phoneNumber.text,
              "postcode": pinCode.text,
              "city": city.text
            }
          ]
        }
      };
      await ApiService.generateToken(
              {"username": userDetails.email, "password": "Abc@123456"},
              getOnlyToken: true)
          .then((value) async {
        print(value.message);
        if (value.status) {
          String token = value.token;
          await ApiService.addAddress(token: value.token, body: bodyData)
              .then((value) async {
            if (value.status) {
              await ApiService.login(token).then((value) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(Preferences.user, jsonEncode(value.data));
              });
              Navigator.pop(context);
            } else {
              Fluttertoast.showToast(
                  msg: value.message, toastLength: Toast.LENGTH_LONG);
            }
          });
        } else {
          Fluttertoast.showToast(
              msg: value.message, toastLength: Toast.LENGTH_LONG);
        }
      });
    }
  }

  String validate(String value) {
    if (value.isNotEmpty)
      return null;
    else
      return "This is required field";
  }
}

Widget addAddressInputField(
    {String labelText,
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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(labelText),
      SizedBox(height: 3),
      Container(
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 7, horizontal: 10)),
              cursorColor: Myapp.primaryColor)),
    ],
  );
}
