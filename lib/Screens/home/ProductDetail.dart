import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/home/widgets/AddtoCartButton.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetail extends StatefulWidget {
  Products products;

  ProductDetail(this.products);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text(widget.products.name, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold))),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.products.name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                  Text(widget.products.sku.toUpperCase(),
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                  SizedBox(height: 15),
                  Column(children: [
                    Stack(children: [
                      CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: false,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              onPageChanged: (index, reason) => setState(() => _current = index)),
                          items: imageSlideView(widget.products.images)),
                      widget.products.attributes.specialPrice != "0" && widget.products.price != 0
                          ? Transform.rotate(
                              angle: -math.pi / 6,
                              child: Stack(children: [
                                Image.asset('assets/badge.png', width: 60.sp, height: 60.sp),
                                Container(
                                    width: 60.sp,
                                    height: 60.sp,
                                    child: Center(
                                        child: Text(getDiscountPercentage(widget.products),
                                            style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis)))
                              ]))
                          : Container()
                    ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.products.images.map((url) {
                          int index = widget.products.images.indexOf(url);
                          return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4)));
                        }).toList())
                  ]),
                  RichText(
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: getSavingPrice(widget.products) + "\n",
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16.sp),
                          children: [
                            TextSpan(
                                text: getPrice(widget.products) + ' ',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                            TextSpan(
                                text: getMRP(widget.products) + ' ',
                                style:
                                    TextStyle(decoration: TextDecoration.lineThrough, color: Colors.blueGrey, fontSize: 14.sp)),
                            TextSpan(text: "(Incl. of all taxes)", style: TextStyle(fontSize: 14.sp, color: Colors.blueGrey))
                          ])),
                  Container(height: 10),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: 'In Stock \n',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16.sp),
                          children: [
                            TextSpan(text: 'Sold by ', style: TextStyle(fontSize: 12.sp, color: Colors.black)),
                            TextSpan(text: 'Pal Departmental Store', style: TextStyle(fontSize: 12.sp, color: Colors.blue)),
                            TextSpan(text: '\n\nFree Shipping', style: TextStyle(fontSize: 16.sp, color: Colors.black))
                          ])),
                  Container(height: 10),
                  RichText(
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: 'Description \n',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.sp),
                          children: [
                            TextSpan(
                                text: widget.products.attributes.description,
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                            TextSpan(text: '\n\nFeatures & Details\n', style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                            TextSpan(
                                text: removeHtmlTags(data: widget.products.attributes.shortDescription),
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                            TextSpan(text: '\n\nProduct Information\n\n', style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                            TextSpan(text: 'Manufacturer : ', style: TextStyle(fontSize: 12.sp, color: Colors.black)),
                            TextSpan(
                                text: '${widget.products.attributes.manufacturer}\n',
                                style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey))
                          ])),
                  Row(children: [
                    Expanded(
                        child: Text("Product Rating",
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black))),
                    RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 20.sp,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0),
                        itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                        ignoreGestures: true,
                        onRatingUpdate: (rating) => print(rating))
                  ]),
                  Container(height: 20.h),
                  SizedBox(height: 50, width: double.infinity, child: AddtoCartButton(widget.products, "Add to Cart"))
                ]))));
  }

  imageSlideView(List<Images> imgList) {
    return imgList
        .map((item) => Container(
            child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(children: <Widget>[
                      Image.network(URLS.PAL_IMAGE_URL + "/pub/media/catalog/product" + item.file,
                          fit: BoxFit.cover, height: 500.sp)
                    ])))))
        .toList();
  }
}
