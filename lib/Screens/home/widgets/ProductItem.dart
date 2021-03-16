import 'dart:math' as math;

import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/ProductsById.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ProductDetail.dart';
import 'AddtoCartButton.dart';

// ignore: must_be_immutable
class ProductItem extends StatefulWidget {
  Map<String, dynamic> bodyData;
  GlobalKey<ScaffoldState> scaffoldKey;
  Function(String count) onProductFound;

  ProductItem(this.bodyData, this.scaffoldKey, {this.onProductFound});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  var productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = Future.wait([ApiService.getFilterProducts(widget.bodyData)]);
  }

  @override
  void didUpdateWidget(covariant ProductItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    productFuture = Future.wait([ApiService.getFilterProducts(widget.bodyData)]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: productFuture,
        builder: (context, AsyncSnapshot snapshot) {
          print("Snapshot Data" + snapshot.toString());
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.data.length > 0 && snapshot.data[0].data.length > 0) {
              ProductsById data = snapshot.data[0];
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (_, index) => Divider(color: Colors.grey, indent: 20, endIndent: 20),
                  itemBuilder: (_, index) => card(data.data[index]),
                  itemCount: data.data.length > 0 ? data.data.length : 0);
            } else {
              return Center(child: Text("Product not found!", style: TextStyle(color: Colors.black)));
            }
          } else {
            return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget card(Products item) {
    return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetail(item))),
        child: Container(
            padding: EdgeInsets.all(10.sp),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(children: [
                Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: Image.network(URLS.PAL_IMAGE_URL + "/pub/media/catalog/product" + item.images[0].file,
                      width: 80.sp, height: 80.sp, fit: BoxFit.contain),
                ),
                item.attributes.specialPrice != "0" && item.price != 0
                    ? Transform.rotate(
                  angle: -math.pi / 6,
                  child: Stack(children: [
                    Image.asset('assets/badge.png', width: 40.sp, height: 40.sp),
                    Container(
                        width: 40.sp,
                        height: 40.sp,
                        child: Center(
                            child: Text(getDiscountPercentage(item),
                                style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis)))
                  ]),
                )
                    : Container()
              ]),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(item.name,
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        SizedBox(height: 7),
                        RichText(
                            text: TextSpan(
                                text: getPrice(item) + "\t",
                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: getMRP(item),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          decoration: TextDecoration.lineThrough,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '\n' + getSavingPrice(item),
                                      style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold))
                                ])),
                        SizedBox(height: 10),
                        Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(height: 32, width: 95, child: AddtoCartButton(item, "ADD")))
                      ])))
            ])));
  }
}
