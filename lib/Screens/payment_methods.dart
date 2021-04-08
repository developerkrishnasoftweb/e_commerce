import 'dart:convert';

import 'package:e_commerce/Models/UserDetails.dart';
import 'package:e_commerce/Models/estimate_shipping_methods_model.dart';
import 'package:e_commerce/Models/payment_details_models.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/constant/color.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentMethods extends StatefulWidget {
  final EstimateShippingMethod estimateShippingMethod;
  final Map<String, dynamic> shippingAddress, billingAddress;

  const PaymentMethods(
      {Key key,
      this.estimateShippingMethod,
      this.billingAddress,
      this.shippingAddress})
      : super(key: key);

  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  PaymentDetails paymentDetails;
  int selectedPaymentMethod = 0;
  bool paymentDetailsFound = true;

  void getPaymentMethods() async {
    Map<String, dynamic> paymentMethodsBody = {
      "addressInformation": {
        "shipping_address": widget.shippingAddress['address'],
        "billing_address": widget.billingAddress['address'],
        "shipping_carrier_code": widget.estimateShippingMethod.carrierCode,
        "shipping_method_code": widget.estimateShippingMethod.methodCode
      }
    };
    await ApiService.generateToken(
            {"username": userdata.email, "password": userdata.password},
            getToken: true)
        .then((token) async {
      await ApiService.shippingAddress(
              body: paymentMethodsBody, token: token.token)
          .then((methods) {
        if (methods.status) {
          setState(() {
            paymentDetails = PaymentDetails.fromJson(methods.data);
          });
        } else {
          setState(() {
            paymentDetailsFound = false;
          });
          Fluttertoast.showToast(msg: methods.message);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 50.sp,
          title: Text("Payment Methods",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold))),
      body: paymentDetailsFound
          ? paymentDetails != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("PAYMENT METHOD(S)",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      ListView.builder(
                          itemBuilder: (_, index) {
                            return buildPaymentMethods(
                                index, paymentDetails.paymentMethods[index]);
                          },
                          itemCount:
                              (paymentDetails?.paymentMethods?.length ?? 0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics()),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("ORDER SUMMERY",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Divider(
                        endIndent: 10,
                        indent: 10,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                    "${paymentDetails?.totals?.totalSegments?.where((element) => element.code == "subtotal")?.first?.title}")),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        "\u20b9${paymentDetails?.totals?.totalSegments?.where((element) => element.code == "subtotal")?.first?.value}")))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                    "${paymentDetails?.totals?.totalSegments?.where((element) => element.code == "shipping")?.first?.title}")),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        "\u20b9${paymentDetails?.totals?.totalSegments?.where((element) => element.code == "shipping")?.first?.value}")))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                    "${paymentDetails?.totals?.totalSegments?.where((element) => element.code == "grand_total")?.first?.title}")),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        "\u20b9${paymentDetails?.totals?.totalSegments?.where((element) => element.code == "grand_total")?.first?.value}")))
                          ],
                        ),
                      ),
                      Divider(
                        endIndent: 10,
                        indent: 10,
                        color: Colors.grey,
                      ),
                      ListView.builder(
                        itemBuilder: (_, index) {
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${paymentDetails.totals.items[index].name}"),
                                        Text(
                                            "Qty: ${paymentDetails.totals.items[index].qty}"),
                                        (paymentDetails?.totals?.items[index]
                                                        ?.options?.length ??
                                                    0) >
                                                0
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 10),
                                                  Text("Details"),
                                                  for (int i = 0;
                                                      i <
                                                          paymentDetails
                                                              .totals
                                                              .items[index]
                                                              .options
                                                              .length;
                                                      i++)
                                                    RichText(
                                                        text: TextSpan(
                                                            text:
                                                                "${paymentDetails.totals.items[index].options[i].label}: ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            children: [
                                                          TextSpan(
                                                            text:
                                                                "${paymentDetails.totals.items[index].options[i].value}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ])),
                                                ],
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                  ),
                                  Text(
                                      "\u20b9${double.parse(paymentDetails?.totals?.items[index]?.price ?? "0") * double.parse(paymentDetails?.totals?.items[index]?.qty ?? "0")}")
                                ],
                              ));
                        },
                        itemCount: (paymentDetails?.totals?.items?.length ?? 0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                      paymentDetails != null
                          ? Container(
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextButton(
                                  onPressed: placeOrder,
                                  child: Text("PLACE ORDER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              primaryColor),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0))))))
                          : SizedBox(),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator())
          : Center(
              child: Text("Unable to fetch payment methods"),
            ),
    );
  }

  void placeOrder() async {
    Map<String, dynamic> orderDetails = {
      "paymentMethod": {
        "method": paymentDetails.paymentMethods[selectedPaymentMethod].code
      },
      "billing_address": widget.billingAddress['address']
    };
    print("Method called");
    await ApiService.generateToken({"username" : userdata.email, "password": userdata.password}, getToken: true).then((token) async {
      await ApiService.paymentInformation(body: orderDetails, token: token.token).then((paymentDetails) {
        print(paymentDetails.message);
      });
    });
  }

  Widget buildPaymentMethods(int index, Methods paymentMethod) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                index == selectedPaymentMethod
                    ? primaryColor
                    : primaryColor.shade50),
            overlayColor: MaterialStateProperty.all(primaryColor.shade50),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
            padding:
                MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20))),
        child: Text(
          "${paymentMethod.title}",
          style: TextStyle(
              color:
                  index == selectedPaymentMethod ? Colors.white : primaryColor,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          setState(() {
            selectedPaymentMethod = index;
          });
        },
      ),
    );
  }
}
