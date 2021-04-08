import 'dart:convert';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Models/countries_model.dart';
import 'package:e_commerce/Models/estimate_shipping_methods_model.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/add_address.dart';
import 'package:e_commerce/Screens/payment_methods.dart';
import 'package:e_commerce/constant/color.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home/widgets/custom_dropdown.dart';
import 'widgets/textinput.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List<Countries> countries = [], billingCountries = [];
  Countries selectedCountry, billingSelectedCountry;
  Regions selectedRegion, billingSelectedRegion;
  String firstName = "",
      lastName = "",
      email = "",
      telephone = "",
      pinCode = "",
      street = "",
      city = "",
      billingFirstName = "",
      billingLastName = "",
      billingEmail = "",
      billingTelephone = "",
      billingPinCode = "",
      billingStreet = "",
      billingCity = "";
  bool isSameAddressAsShipping = false, isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  List<Addresses> addresses;
  int selectedAddressIndex = 0;

  void getUserDetails() async {
    var data = sharedPreferences.getString(Preferences.user);
    if (data != null) {
      setState(() {
        addresses = UserDetails.fromJson(jsonDecode(data)).addresses;
      });
    }
  }

  getCountries() async {
    List<Countries> tempCountries = await ApiService.getCountries();
    if ((tempCountries?.length ?? 0) > 0) {
      setState(() {
        countries = billingCountries = tempCountries;
        selectedCountry = billingSelectedCountry =
            countries.where((element) => element.id == "IN").first;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCountries();
    getUserDetails();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 50.sp,
          title: Text("Checkout",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("SHIPPING ADDRESS(S)",
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            if ((addresses?.length ?? 0) > 0)
              for (int i = 0; i < (addresses?.length ?? 0); i++)
                buildAddressCard(i, addresses[i],
                    i == selectedAddressIndex ? primaryColor : Colors.grey),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddAddress())).then((value) => getUserDetails),
                    icon: Icon(Icons.add, color: primaryColor),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(primaryColor.shade50),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(
                          color: primaryColor,
                          width: 2
                        ),
                        borderRadius: BorderRadius.circular(7)
                      ))
                    ),
                    label: Text("ADD ADDRESS", style: TextStyle(
                      color: primaryColor
                    ))),
              ),
            )
          ],
        ),
        /* child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Text("Shipping Address",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp)),
              ),
              input(
                  text: "First Name",
                  validator: validate,
                  onChanged: (v) => setState(() => firstName = v)),
              input(
                  text: "Last Name",
                  validator: validate,
                  onChanged: (v) => setState(() => lastName = v)),
              input(
                  text: "Email",
                  validator: validate,
                  onChanged: (v) => setState(() => email = v)),
              input(
                  text: "Telephone",
                  validator: validate,
                  onChanged: (v) => setState(() => telephone = v)),
              input(
                  text: "Postal Code",
                  validator: validate,
                  onChanged: (v) => setState(() => pinCode = v)),
              input(
                  text: "Street",
                  validator: validate,
                  onChanged: (v) => setState(() => street = v)),
              input(
                  text: "City",
                  validator: validate,
                  onChanged: (v) => setState(() => city = v)),
              (selectedCountry?.availableRegions?.length ?? 0) > 0
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
                  : SizedBox(),
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
                  : SizedBox(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Text("Billing Address",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp)),
              ),
              CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Same as shipping address"),
                  value: isSameAddressAsShipping,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (v) {
                    setState(() {
                      isSameAddressAsShipping = !isSameAddressAsShipping;
                    });
                    if (!isSameAddressAsShipping) {
                      Future.delayed(Duration(milliseconds: 100), () {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent / 2,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      });
                    }
                  }),
              Visibility(
                visible: !isSameAddressAsShipping,
                child: Column(
                  children: [
                    input(
                        text: "First Name",
                        validator: isSameAddressAsShipping ? null : validate,
                        onChanged: (v) => setState(() => billingFirstName = v)),
                    input(
                        text: "Last Name",
                        validator: isSameAddressAsShipping ? null : validate,
                        onChanged: (v) => setState(() => billingLastName = v)),
                    input(
                        text: "Email",
                        validator: isSameAddressAsShipping ? null : validate,
                        onChanged: (v) => setState(() => billingEmail = v)),
                    input(
                        text: "Telephone",
                        validator: isSameAddressAsShipping ? null : validate,
                        onChanged: (v) => setState(() => billingTelephone = v)),
                    input(
                        text: "Postal Code",
                        validator: isSameAddressAsShipping ? null : validate,
                        onChanged: (v) => setState(() => billingPinCode = v)),
                    input(
                        text: "Street",
                        validator: isSameAddressAsShipping ? null : validate,
                        onChanged: (v) => setState(() => billingStreet = v)),
                    input(
                        text: "City",
                        validator: isSameAddressAsShipping ? null : validate,
                        onChanged: (v) => setState(() => billingCity = v)),
                    (billingSelectedCountry?.availableRegions?.length ?? 0) > 0
                        ? dropDown<Regions>(
                            value: billingSelectedRegion,
                            items: billingSelectedCountry.availableRegions
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
                                billingSelectedRegion = region;
                              });
                            })
                        : SizedBox(),
                    billingCountries.length > 0
                        ? dropDown<Countries>(
                            onChanged: (Countries country) {
                              setState(() {
                                billingSelectedCountry = country;
                              });
                            },
                            label: "Country *",
                            items: billingCountries
                                .map((country) => DropdownMenuItem<Countries>(
                                    child: Text("${country.fullNameEnglish}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    value: country))
                                .toList(),
                            value: billingSelectedCountry)
                        : SizedBox(),
                  ],
                ),
              ),
              Container(
                  height: 50,
                  width: double.infinity,
                  alignment: isLoading ? Alignment.center : null,
                  margin: EdgeInsets.all(10),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : TextButton(
                          onPressed: checkout,
                          child: Text("Checkout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(0))))))
            ],
          ),
        ), */
      ),
      floatingActionButton: Container(
          height: 50,
          width: double.infinity,
          alignment: isLoading ? Alignment.center : null,
          margin: EdgeInsets.all(10),
          child: isLoading
              ? CircularProgressIndicator()
              : TextButton(
                  onPressed: checkout,
                  child: Text("Checkout",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)))))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void checkout() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> shippingAddressBody = {
      "address": {
        "region": addresses[selectedAddressIndex].region.region,
        "region_id": addresses[selectedAddressIndex].region.regionId,
        "region_code": addresses[selectedAddressIndex].region.regionCode,
        "country_id": addresses[selectedAddressIndex].countryId,
        "street": addresses[selectedAddressIndex].street,
        "postcode": addresses[selectedAddressIndex].postcode,
        "city": addresses[selectedAddressIndex].city,
        "firstname": addresses[selectedAddressIndex].firstname,
        "lastname": addresses[selectedAddressIndex].lastname,
        "customer_id": userdata.id,
        "email": userdata.email,
        "telephone": addresses[selectedAddressIndex].telephone,
        "same_as_billing": 1
      }
    };
    Map<String, dynamic> billingAddressBody;
    if (isSameAddressAsShipping) {
      billingAddressBody = shippingAddressBody;
    } else {
      billingAddressBody = {
        "address": {
          "region": addresses[selectedAddressIndex].region.region,
          "region_id": addresses[selectedAddressIndex].region.regionId,
          "region_code": addresses[selectedAddressIndex].region.regionCode,
          "country_id": addresses[selectedAddressIndex].countryId,
          "street": addresses[selectedAddressIndex].street,
          "postcode": addresses[selectedAddressIndex].postcode,
          "city": addresses[selectedAddressIndex].city,
          "firstname": addresses[selectedAddressIndex].firstname,
          "lastname": addresses[selectedAddressIndex].lastname,
          "customer_id": userdata.id,
          "email": userdata.email,
          "telephone": addresses[selectedAddressIndex].telephone,
          "same_as_billing": 1
        }
      };
    }
    print({"username": userdata.email, "password": userdata.password});
    await ApiService.generateToken(
            {"username": userdata.email, "password": userdata.password},
            getToken: true)
        .then((tokenGenerate) async {
      if(tokenGenerate.status) {
        await ApiService.estimateShippingMethods(
            token: tokenGenerate.token, body: shippingAddressBody)
            .then((shippingMethods) {
          if (shippingMethods.status) {
            if ((shippingMethods?.data?.length ?? 0) > 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PaymentMethods(
                          estimateShippingMethod: EstimateShippingMethod.fromJson(
                              shippingMethods.data[0]),
                          billingAddress: billingAddressBody,
                          shippingAddress: shippingAddressBody)));
            } else {
              Fluttertoast.showToast(msg: "Unable to get payment methods");
            }
          } else {
            Fluttertoast.showToast(msg: shippingMethods.message);
          }
        });
      } else {
        Fluttertoast.showToast(msg: tokenGenerate.message);
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  String validate(String value) {
    if (value.isNotEmpty)
      return null;
    else
      return "This field is required";
  }

  buildAddressCard(int i, Addresses address, Color color) {
    TextStyle style = TextStyle(color: color);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: i == selectedAddressIndex ? primaryColor : Colors.grey,
            width: 2),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${address.firstname} ${address.lastname}", style: style),
          Text(
              "${address.street.toString().replaceAll("[", "").replaceAll("]", "")}",
              style: style),
          Text("${address.city}, ${address.region.region} ${address.postcode}",
              style: style),
          Text("${address.countryId}", style: style),
          Text("${address.telephone}", style: style),
        ],
      ),
    );
  }
}
