import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'category.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartItem> cartItems = [
    CartItem(
        image: "assets/images/products/product1.png",
        category: "By Classiques",
        price: "120.0",
        name: "Maroon Printed Art Silk Saree With blouse",
        quantity: 1,
        shippingCharge: "12.0"),
    CartItem(
        image: "assets/images/products/product2.png",
        category: "By Classiques",
        price: "120.0",
        name: "Maroon Printed Art Silk Saree With blouse",
        quantity: 1,
        shippingCharge: "12.0"),
    CartItem(
        image: "assets/images/products/product3.png",
        category: "By Classiques",
        price: "120.0",
        name: "Maroon Printed Art Silk Saree With blouse",
        quantity: 1,
        shippingCharge: "12.0"),
    CartItem(
        image: "assets/images/products/product4.png",
        category: "By Classiques",
        price: "120.0",
        name: "Maroon Printed Art Silk Saree With blouse",
        quantity: 1,
        shippingCharge: "12.0"),
    CartItem(
        image: "assets/images/products/product5.png",
        category: "By Classiques",
        price: "120.0",
        name: "Maroon Printed Art Silk Saree With blouse",
        quantity: 1,
        shippingCharge: "12.0"),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: appBarIconButton(
                imagePath: "assets/icons/left-arrow.png", color: Colors.white, onPressed: () => Navigator.pop(context)),
            title: Text("Cart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
            centerTitle: false,
            backgroundColor: Color(0xff4E72D4)),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemBuilder: (_, index) {
                return Container(
                  height: 400,
                  width: size.width,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Image.asset(cartItems[index].image, height: 180, width: size.width * 0.4, fit: BoxFit.fill),
                        Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(cartItems[index].name,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          SizedBox(height: 10),
                          Text(cartItems[index].category,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          SizedBox(height: 10),
                          Row(children: [
                            Text("Quantity",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(width: 10),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                                child: DropdownButton(
                                    isDense: true,
                                    onChanged: (value) => setState(() => cartItems[index].quantity = value),
                                    value: cartItems[index].quantity,
                                    items: [1, 2, 3, 4, 5]
                                        .map((e) => DropdownMenuItem(child: Text("$e"), value: e))
                                        .toList(),
                                    underline: SizedBox.shrink()))
                          ]),
                          SizedBox(height: 20),
                          Text("\$" + cartItems[index].price,
                              style: TextStyle(color: Color(0xff4E72D4), fontWeight: FontWeight.bold, fontSize: 25),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)
                        ]))
                      ]),
                      SizedBox(height: 20),
                      Row(children: [
                        Expanded(
                            child: FlatButton(
                                onPressed: () {},
                                child: Text("Remove", style: TextStyle(color: Colors.grey)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.grey)),
                                padding: EdgeInsets.symmetric(vertical: 20))),
                        SizedBox(width: 10),
                        Expanded(
                            child: FlatButton(
                                onPressed: () {},
                                child: Text(
                                  "MOVE TO WISHLIST",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.grey)),
                                padding: EdgeInsets.symmetric(vertical: 20)))
                      ]),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PRICE DETAILS", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text("Items Total",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                            Text("\$125.00", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                          ]),
                          SizedBox(height: 5),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text("Shipping Charge*",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                            Text("\$12.00", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                          ]),
                          SizedBox(height: 10),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(
                              "Total",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\$137.00",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ])
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: cartItems.length,
              physics: BouncingScrollPhysics(),
            )),
          ],
        ));
  }
}

class CartItem {
  final String image, name, category, price, shippingCharge;
  int quantity;

  CartItem({this.category, this.image, this.name, this.price, this.quantity, this.shippingCharge});
}
