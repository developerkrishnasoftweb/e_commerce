import 'package:e_commerce/Models/countries_model.dart';
import 'package:e_commerce/Models/estimate_shipping_methods_model.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/payment_methods.dart';
import 'package:e_commerce/constant/color.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
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
  bool isSameAddressAsShipping = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 50.sp,
          title: Text("Checkout",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 60),
        child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                    fontSize: 16, fontWeight: FontWeight.w500)),
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
                                    fontSize: 16, fontWeight: FontWeight.w500)),
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
            )
          ]),
        ),
      ),
      floatingActionButton: Container(
          height: 50,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextButton(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void checkout() async {
    if (formKey.currentState.validate()) {
      Map<String, dynamic> shippingAddressBody = {
        "address": {
          "region": selectedRegion.name,
          "region_id": selectedRegion.id,
          "region_code": selectedRegion.code,
          "country_id": selectedCountry.id,
          "street": [street],
          "postcode": pinCode,
          "city": city,
          "firstname": firstName,
          "lastname": lastName,
          "customer_id": userdata.id,
          "email": email,
          "telephone": telephone,
          "same_as_billing": isSameAddressAsShipping ? 1 : 0
        }
      };
      Map<String, dynamic> billingAddressBody;
      if (isSameAddressAsShipping) {
        billingAddressBody = shippingAddressBody;
      } else {
        billingAddressBody = {
          "address": {
            "region": billingSelectedRegion.name,
            "region_id": billingSelectedRegion.id,
            "region_code": billingSelectedRegion.code,
            "country_id": billingSelectedCountry.id,
            "street": [billingStreet],
            "postcode": billingPinCode,
            "city": billingCity,
            "firstname": billingFirstName,
            "lastname": billingLastName,
            "customer_id": userdata.id,
            "email": billingEmail,
            "telephone": billingTelephone,
            "same_as_billing": 1
          }
        };
      }
      await ApiService.generateToken(
              {"username": userdata.email, "password": userdata.password},
              getToken: true)
          .then((tokenGenerate) async {
        await ApiService.estimateShippingMethods(
                token: tokenGenerate.token, body: shippingAddressBody)
            .then((shippingMethods) {
          if (shippingMethods.status) {
            if ((shippingMethods?.data?.length ?? 0) > 0)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PaymentMethods(
                          estimateShippingMethod:
                              EstimateShippingMethod.fromJson(
                                  shippingMethods.data[0]),
                          billingAddress: billingAddressBody,
                          shippingAddress: shippingAddressBody)));
          } else {
            print(shippingMethods.message);
          }
        });
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
