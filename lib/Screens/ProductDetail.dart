import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/CartScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

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
                  Text(widget.products.name,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                  Text("Amul".toUpperCase(),
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                  SizedBox(height: 15),
                  Column(children: [
                    CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: false,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            onPageChanged: (index, reason) => setState(() => _current = index)),
                        items: imageSlideView(widget.products.images)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.map((url) {
                          int index = imgList.indexOf(url);
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
                          text: 'You Save ₹ 22.50 \n',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16.sp),
                          children: [
                            TextSpan(
                                text: "Save ₹ 225.0 ",
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                            TextSpan(
                                text: '₹ '+ widget.products.price.toString() + " ",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough, color: Colors.blueGrey, fontSize: 14.sp)),
                            TextSpan(
                                text: "(Incl. of all taxes)", style: TextStyle(fontSize: 14.sp, color: Colors.blueGrey))
                          ])),
                  Container(height: 10),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: 'In Stock \n',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16.sp),
                          children: [
                            TextSpan(text: 'Sold by ', style: TextStyle(fontSize: 12.sp, color: Colors.black)),
                            TextSpan(text: 'Reliance Retail', style: TextStyle(fontSize: 12.sp, color: Colors.blue)),
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
                                text:
                                    "Who doesn't like a chunk of creamy, velvety, smooth and mouth-watering butter? Made with fresh ingredients, "
                                    "Amul Butter is a multi-purpose butter that can be used as a spread on bread, paratha, roti, naan and sandwiches. "
                                    "It also makes an excellent topping for Pav-bhaji, dal, soups, salads, rice as well as a great cooking medium for "
                                    "Paneer Butter Masala, Dal Makhni and a variety "
                                    "of delightful recipes. So what are you waiting for? Buy this product online today!",
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                            TextSpan(
                                text: '\n\nFeatures & Details\n',
                                style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                            TextSpan(
                                text:
                                    "Smooth and creamy\nEasy to spread\nEnhances the flavour\nAmul Butter is the tastiest",
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                            TextSpan(
                                text: '\n\nProduct Information\n\n',
                                style: TextStyle(fontSize: 16.sp, color: Colors.black)),
                            TextSpan(text: 'Brand : ', style: TextStyle(fontSize: 12.sp, color: Colors.black)),
                            TextSpan(text: 'Amul\n', style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey)),
                            TextSpan(text: 'Manufacturer : ', style: TextStyle(fontSize: 12.sp, color: Colors.black)),
                            TextSpan(
                                text: 'Hindustan Unilever Limited\n',
                                style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey)),
                            TextSpan(
                                text: 'Country of Origin : ', style: TextStyle(fontSize: 12.sp, color: Colors.black)),
                            TextSpan(text: 'India\n', style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey)),
                            TextSpan(text: 'Food Type : ', style: TextStyle(fontSize: 12.sp, color: Colors.black)),
                            TextSpan(text: 'Veg\n', style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey))
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
                  Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.lightBlue[100], blurRadius: 10, offset: Offset(0, 5))
                      ]),
                      child: FlatButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen())),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text("Add to Cart",
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                          color: Myapp.primaryColor))
                ]))));
  }

  List<String> imgList = [
    'https://www.jiomart.com/images/product/420x420/490001392/amul-pasteurised-butter-500-g-carton-0-20210208.jpg',
    'https://www.jiomart.com/images/product/420x420/490001392/amul-pasteurised-butter-500-g-carton-1-20210208.jpg',
    'https://www.jiomart.com/images/product/420x420/490001392/amul-pasteurised-butter-500-g-carton-2-20210208.jpg',
    'https://www.jiomart.com/images/product/420x420/490001392/amul-pasteurised-butter-500-g-carton-4-20210208.jpg'
  ];

  imageSlideView(List<Images> imgList) {
    return imgList
        .map((item) => Container(
            child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(children: <Widget>[Image.network(URLS.PAL_IMAGE_URL + "/pub/media/catalog/product" + item.file, fit: BoxFit.cover, height: 500.sp)])))))
        .toList();
  }
}
