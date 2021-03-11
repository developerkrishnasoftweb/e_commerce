import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliverAddressTo extends StatefulWidget {
  @override
  _DeliverAddressToState createState() => _DeliverAddressToState();
}

class _DeliverAddressToState extends State<DeliverAddressTo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
            color: Colors.grey[200],
            width: 150.sp,
            child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.location_on_rounded, color: Colors.grey),
              SizedBox(width: 10.sp),
              RichText(
                  text: TextSpan(
                      text: "Deliver to\t\t",
                      style: TextStyle(color: Colors.grey, fontSize: 11.sp, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "394221", style: TextStyle(color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.bold))
                      ]),
                  textAlign: TextAlign.center)
            ])));
  }
}
