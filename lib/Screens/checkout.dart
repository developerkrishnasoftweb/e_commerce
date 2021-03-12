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
          Text("Address Information"),
          input(context: context, text: ""),
        ]),
      ),
    );
  }
}
