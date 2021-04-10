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
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Sr.No. #$index"),
                                    Text("Date - ${orders[index].createdAt}"),
                                    Text(
                                        "Order Total - \u20b9${orders[index].grandTotal}"),
                                    Text(
                                        "Status - ${orders[index].status[0].toUpperCase() + orders[index].status.substring(1)}"),
                                    ExpansionTile(
                                      title: Text("View Order"),
                                      children: orders[index].items.map((item) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("PRODUCT NAME : ${item.name}"),
                                            Text("SKU : ${item.sku}"),
                                            Text("PRICE : ${item.price}"),
                                            Text(
                                                "QTY : Ordered: ${item.qtyOrdered}"),
                                            Text(
                                                "SUBTOTAL : \u20b9${item.baseRowTotalInclTax}"),
                                            (orders[index]
                                                        .items
                                                        .indexOf(item) ==
                                                    (orders[index]
                                                            .items
                                                            .length -
                                                        1))
                                                ? SizedBox()
                                                : Divider(color: Colors.grey)
                                          ],
                                        );
                                      }).toList(),
                                      tilePadding: EdgeInsets.zero,
                                      childrenPadding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      expandedAlignment: Alignment.centerLeft,
                                    )
                                  ])));
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : Center(child: Text("No orders found")));
  }

  Widget shrinkAble(
      {Duration duration,
      double height,
      double width,
      EdgeInsetsGeometry padding,
      EdgeInsetsGeometry margin,
      List<BoxShadow> boxShadow,
      Widget child,
      Color backGroundColor}) {
    double initHeight = height, initWidth = width;
    void onTap() {
      setState(() {
        height -= 10;
        width -= 10;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          height = initHeight;
          width = initWidth;
        });
      });
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: height,
        width: width,
        alignment: Alignment.center,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backGroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: boxShadow ??
              [BoxShadow(color: Colors.grey.shade600, blurRadius: 5)],
        ),
        child: child,
      ),
    );
  }
}
