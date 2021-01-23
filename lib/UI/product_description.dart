import 'package:e_commerce/COMMON/rating_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'category.dart';

class ProductDescription extends StatefulWidget {
  final String heroTag;
  ProductDescription({this.heroTag});
  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: appBarIconButton(
            imagePath: "assets/icons/left-arrow.png",
            onPressed: () => Navigator.pop(context)),
        title: Text(
          "Shopping",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: [
          appBarIconButton(
              imagePath: "assets/icons/loupe.png", onPressed: () {}),
          appBarIconButton(
              imagePath: "assets/icons/heart.png", onPressed: () {}),
          appBarIconButton(
              imagePath: "assets/icons/shopping-cart.png", onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Hero(
                  tag: widget.heroTag,
                  child: Image.asset(
                    widget.heroTag,
                    height: size.height * 0.4,
                    width: size.width * 0.7,
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Beige printed art silk saree with blouse",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
                    text: "\$125.00 \t",
                    style: TextStyle(
                        color: Color(0xff4E72D4),
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                    children: [
                  TextSpan(
                      text: "\$150.00",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Color(0xff212121),
                          fontSize: 16)),
                  WidgetSpan(
                      child: SizedBox(
                    width: 10,
                  )),
                  TextSpan(
                      text: "25% OFF",
                      style: TextStyle(color: Color(0xffBBBBBB), fontSize: 16))
                ])),
            SizedBox(
              height: 10,
            ),
            RichText(
                text: TextSpan(
                    text: "DEALS END IN : ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    children: [
                  TextSpan(
                      text: "01:48:52",
                      style: TextStyle(color: Color(0xffA52813), fontSize: 18)),
                ])),
            SizedBox(
              height: 10,
            ),
            RichText(
                text: TextSpan(
                    text: "Estimated Delivery : ",
                    style: TextStyle(color: Color(0xffBBBBBB), fontSize: 14),
                    children: [
                  TextSpan(
                      text: "9 JAN 2021",
                      style: TextStyle(color: Color(0xff212121), fontSize: 14)),
                ])),
            SizedBox(
              height: 10,
            ),
            RatingBuilder(
              onChanged: (_) {},
              iconSize: 30,
              itemExtent: 27,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: RichText(
                  text: TextSpan(
                      text: "4.2 / 5.0 ",
                      style: TextStyle(color: Color(0xffCBCBCB), fontSize: 14),
                      children: [
                    TextSpan(
                        text: "Rating",
                        style: TextStyle(
                            color: Color(0xff212121),
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ])),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: Color(0xffBBBBBB))),
                hintText: "CASH ON DELIVERY AVAILABLE",
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintStyle: TextStyle(color: Color(0xffBBBBBB), fontSize: 19),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: Color(0xffBBBBBB))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("ADD TO CART", style: TextStyle(color: Color(0xff4E72D4)),),
                    height: 60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: BorderSide(color: Color(0xff4E72D4))
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("BUY NOW", style: TextStyle(color: Colors.white),),
                    height: 60,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                    ),
                    color: Color(0xff4E72D4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
