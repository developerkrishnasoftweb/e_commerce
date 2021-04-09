import 'package:e_commerce/Models/order_details_model.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'NavigationDrawer.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<OrderDetails> orders = [];

  getOrders() async {
    await ApiService.getOrders().then((value) {
      if (value.status) {
        value.data.forEach((v) {
          setState(() {
            orders.add(OrderDetails.fromJson(v));
          });
        });
      } else {
        orders = null;
        Fluttertoast.showToast(msg: value.message);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text("My Orders",
                style:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold))),
        drawer: NavigationDrawer(),
        body: orders != null
            ? orders.length > 0
                ? ListView.builder(
                    itemCount: orders.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10.sp),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          elevation: 10,
                          child: Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: Row(children: [
                                Image(
                                    image: NetworkImage(
                                        'https://www.jiomart.com/images/product/420x420/490008332/closeup-ever-fresh-red'
                                        '-hot-gel-toothpaste-150-g-pack-of-2-0-20201217.jpg'),
                                    width: 50.sp,
                                    height: 50.sp),
                                Container(width: 15.sp),
                                Expanded(
                                    child: RichText(
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                            text:
                                                'Closeup Ever Fresh Red Hot Gel Toothpaste 150 g (Pack of 2) \n',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '₹ 100.00, Order Completed\n',
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Colors.green,
                                                      height: 2.sp)),
                                              TextSpan(
                                                  text:
                                                      '20 Oct 2020, 11:54 PM',
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color:
                                                          Colors.blueGrey,
                                                      height: 1.5.sp))
                                            ])))
                              ])));
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : Center(child: Text("No orders found")));
  }
}
