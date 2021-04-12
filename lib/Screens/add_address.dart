import 'dart:convert';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Models/countries_model.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/home/widgets/custom_dropdown.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/textinput.dart';

class AddAddress extends StatefulWidget {
  final Addresses addressDetail;

  const AddAddress({Key key, this.addressDetail}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController firstName = TextEditingController(),
      lastName = TextEditingController(),
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
      pinCode.text = widget.addressDetail.postcode;
    }
    getCountries();
    getUser();
  }

  getUser() async {
    Map userMap = jsonDecode(sharedPreferences.getString(Preferences.user));
    setState(() {
      userDetails = UserDetails.fromJson(userMap);
    });
  }

  getCountries() async {
    List<Countries> tempCountries = await ApiService.getCountries();
    if (tempCountries.length > 0) {
      setState(() {
        countries = tempCountries;
        selectedCountry =
            countries.where((element) => element.id == "IN").first;
        if (widget.addressDetail != null) {
          selectedRegion = selectedCountry.availableRegions
              .where((element) =>
                  element.id == widget.addressDetail.region.regionId.toString())
              .first;
        }
      });
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
                input(
                    text: "First Name *",
                    controller: firstName,
                    validator: validate),
                input(
                    text: "Last Name *",
                    controller: lastName,
                    validator: validate),
                input(
                    text: "Phone Number *",
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
                input(
                    text: "Street 1 *",
                    controller: street,
                    validator: validate),
                input(
                    text: "Street 2 *",
                    controller: street1,
                    validator: validate),
                input(text: "City *", controller: city, validator: validate),
                selectedCountry?.availableRegions != null
                    ? selectedCountry.availableRegions.length > 0
                        ? dropDown<Regions>(
                            value: selectedRegion,
                            items: selectedCountry.availableRegions
                                .map((region) => DropdownMenuItem<Regions>(
                                    child: Text("${region.name}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    value: region))
                                .toList(),
                            label: "State/Province *",
                            onChanged: (region) {
                              setState(() {
                                selectedRegion = region;
                              });
                            })
                        : input(
                            text: "State/Province *",
                            controller: state,
                            readOnly: selectedCountry != null
                                ? !(selectedCountry.id == "IN")
                                : false,
                            validator: validate)
                    : input(
                        text: "State/Province *",
                        controller: state,
                        readOnly: selectedCountry != null
                            ? !(selectedCountry.id == "IN")
                            : false,
                        validator: validate),
                input(
                    text: "Zip/Postal Code *",
                    controller: pinCode,
                    validator: validate),
                countries.length > 0
                    ? dropDown<Countries>(
                        onChanged: (Countries country) {
                          setState(() {
                            selectedCountry = country;
                          });
                        },
                        label: "Country *",
                        items: countries
                            .map((country) => DropdownMenuItem<Countries>(
                                child: Text("${country.fullNameEnglish}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                value: country))
                            .toList(),
                        value: selectedCountry)
                    : input(
                        text: "Country *",
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
    if (formKey.currentState.validate()) {
      if (selectedRegion == null && selectedCountry == null) {
        Fluttertoast.showToast(msg: "All fields are required");
        return;
      }
      Map<String, dynamic> bodyData = {
        "customer": {
          "email": userdata.email,
          "firstname": firstName.text,
          "lastname": lastName.text,
          "dob": userDetails.dob,
          "gender": userDetails.gender,
          "website_id": userDetails.websiteId,
          "addresses": [
            {
              "id": widget.addressDetail.id.toString(),
              "customerId": userdata.id,
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
              {"username": userdata.email, "password": userdata.password},
              getToken: true)
          .then((value) async {
        if (value.status) {
          await ApiService.updateAddress(body: bodyData, token: value.token)
              .then((value) async {
            if (value.status) {
              await sharedPreferences.setString(
                  Preferences.user,
                  jsonEncode(UserDetails.fromJson(value.data)
                    ..password = userdata.password
                    ..toJson()));
              Fluttertoast.showToast(msg: value.message);
              Navigator.pop(context);
            } else {
              Fluttertoast.showToast(msg: value.message);
            }
          });
        } else {
          Fluttertoast.showToast(msg: value.message);
        }
      });
    }
  }

  void addAddress() async {
    if (formKey.currentState.validate()) {
      if (selectedRegion == null && selectedCountry == null) {
        Fluttertoast.showToast(msg: "All fields are required");
        return;
      }
      Map<String, dynamic> bodyData = {
        "customer": {
          "email": userdata.email,
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
              {"username": userdata.email, "password": userdata.password},
              getToken: true)
          .then((value) async {
        print(value.message);
        if (value.status) {
          String token = value.token;
          await ApiService.addAddress(token: value.token, body: bodyData)
              .then((value) async {
            if (value.status) {
              await ApiService.login(token).then((value) async {
                await sharedPreferences.setString(
                    Preferences.user,
                    jsonEncode(UserDetails.fromJson(value.data)
                      ..password = userdata.password
                      ..toJson()));
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
      return "This field is required";
  }
}
