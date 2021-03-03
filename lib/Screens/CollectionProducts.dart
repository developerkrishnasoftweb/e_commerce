import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/ProductsById.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ProductDetail.dart';

class CollectionProducts extends StatefulWidget {
  List<Categories> list;
  int id;

  CollectionProducts({this.list, this.id});

  @override
  _CollectionProductsState createState() => _CollectionProductsState();
}

class _CollectionProductsState extends State<CollectionProducts> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text("Product", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})]),
        body: Container(
            child: Column(children: [
          Expanded(
              child: FutureBuilder(
                  future: Future.wait([ApiService.getProductsById(widget.id.toString())]),
                  builder: (context, AsyncSnapshot snapshot) {
                    print("Snapshot Data" + snapshot.toString());
                    if (snapshot.connectionState == ConnectionState.done) {
                      if(snapshot.data != null && snapshot.data[0].data.length > 0) {
                        ProductsById data = snapshot.data[0];
                        return ListView.separated(
                            separatorBuilder: (_, index) => Divider(color: Colors.grey, indent: 20, endIndent: 20),
                            itemBuilder: (_, index) => card(data.data[index]),
                            itemCount: data.data.length > 0 ? data.data.length : 0);
                      } else {
                        return Center(child: Text("Product not found!", style: TextStyle(color: Colors.black)));
                      }
                    } else
                      return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
                  }))
        ])));
  }

  Widget card(Products item) {
    return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetail(item))),
        child: Container(
            padding: EdgeInsets.all(20),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.network(URLS.PAL_IMAGE_URL + "/pub/media/catalog/product" + item.images[0].file,
                  width: 100, height: 100, fit: BoxFit.contain),
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
                                text: "\u20b9${(item.price * item.quantity) - (item.quantity * item.discount)}\t",
                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: "\u20b9${item.price * item.quantity}",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "\t\tYou Save \u20b9${item.discount * item.quantity}",
                                  style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold))
                            ])),
                        SizedBox(height: 10),
                        item.inCart
                            ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: FlatButton(
                                        child: Icon(Icons.remove, color: Colors.white),
                                        onPressed: () {
                                          if (item.quantity != 1) {
                                            setState(() => item.quantity--);
                                          } else {
                                            setState(() => item.inCart = false);
                                          }
                                        },
                                        color: Myapp.primaryColor,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),
                                SizedBox(width: 10),
                                Text(item.quantity.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                SizedBox(width: 10),
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: FlatButton(
                                        child: Icon(Icons.add, color: Colors.white),
                                        onPressed: item.quantity <= item.maxQuantity
                                            ? () {
                                                if (item.quantity != item.maxQuantity) {
                                                  setState(() => item.quantity++);
                                                }
                                              }
                                            : null,
                                        color: item.quantity >= item.maxQuantity ? Myapp.primaryColor.withOpacity(0.7) : Myapp.primaryColor,
                                        disabledColor: Myapp.primaryColor.withOpacity(0.7),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))))
                              ])
                            : Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                    height: 32,
                                    width: 95,
                                    child: FlatButton(
                                        child: Text("ADD", style: TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          setState(() => item.inCart = true);
                                          scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Added to cart successfully")));
                                        },
                                        color: Myapp.primaryColor)))
                      ])))
            ])));
  }
}

class Item {
  final String image, name, category;
  final double price, maxQuantity, discount;
  int quantity;
  bool inCart;

  Item({this.image, this.name, this.category, this.price, this.maxQuantity, this.discount, this.inCart: false, this.quantity});
}
