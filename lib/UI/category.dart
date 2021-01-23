import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:e_commerce/UI/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Category extends StatefulWidget {
  final String title;
  Category({this.title});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> with SingleTickerProviderStateMixin{
  AnimationController animationController;


  List<String> categories = [
    "Georgette Saree",
    "Silk Saree",
    "Chiffon Saree",
    "Chiffon Saree"
  ];
  List<String> products = [
    "assets/images/products/product1.png",
    "assets/images/products/product2.png",
    "assets/images/products/product3.png",
    "assets/images/products/product4.png",
    "assets/images/products/product5.png",
    "assets/images/products/product6.png",
    "assets/images/products/product7.png",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animationController.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: appBarIconButton(
            imagePath: "assets/icons/left-arrow.png", onPressed: () {}),
        title: Text(
          widget.title ?? "Category",
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
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            width: size.width,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 10,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return FlatButton(
                  onPressed: () {},
                  child: Text(
                    categories[index],
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black),
                  ),
                );
              },
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
            ),
          ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 10),
                  itemCount: products.length,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDescription(
                                    heroTag: products[index],
                                  ))),
                      child: Hero(
                        tag: products[index],
                        child: Column(
                          children: [
                            Image.asset(
                              products[index],
                              fit: BoxFit.fill,
                              height: size.height * 0.21,
                              width: size.width * 0.41,
                            ),
                            // SizedBox(height: 5,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Yellow Printed Saree",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "\$120.0",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff4E72D4)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

IconButton appBarIconButton(
    {@required String imagePath, @required VoidCallback onPressed}) {
  return IconButton(
    onPressed: onPressed,
    splashRadius: 25,
    icon: ImageIcon(
      AssetImage(imagePath),
      color: Colors.black,
    ),
  );
}
