import 'package:e_commerce/Models/estimate_shipping_methods_model.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:flutter/material.dart';

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
  void getPaymentMethods() async {
    Map<String, dynamic> paymentMethodsBody = {
      "addressInformation": {
        "shipping_address": widget.shippingAddress['address'],
        "billing_address": widget.billingAddress['address'],
        "shipping_carrier_code": widget.estimateShippingMethod.carrierCode,
        "shipping_method_code": widget.estimateShippingMethod.methodCode
      }
    };
    print(paymentMethodsBody);
    await ApiService.generateToken(
            {"username": userdata.email, "password": userdata.password},
            getToken: true)
        .then((token) async {
      await ApiService.shippingAddress(
              body: paymentMethodsBody, token: token.token)
          .then((methods) {
        print(methods.data);
        print(methods.message);
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
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
