import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'widgets/textinput.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 50.sp,
          title: Text("Checkout",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text("Address Information", style: TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 17.sp
          //   )),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Text("Shipping Information", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp
            )),
          ),
          input(context: context, text: "First Name"),
          input(context: context, text: "Last Name"),
          input(context: context, text: "Email"),
          input(context: context, text: "Telephone"),
          input(context: context, text: "Postal Code"),
          input(context: context, text: "Region"),
          input(context: context, text: "Region Code"),
          input(context: context, text: "Country ID"),
          input(context: context, text: "Street"),

        ]),
      ),
    );
  }
}
