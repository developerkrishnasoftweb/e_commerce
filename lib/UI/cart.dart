import 'package:e_commerce/main.dart';
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
        category: "Groccery",
        price: 12,
        name: "Aashirvaad Multigrain Atta 5 kg",
        quantity: 1,
        discount: 10,
        maxQuantity: 5),
    CartItem(
        image: "assets/images/products/product2.png",
        category: "Groccery",
        price: 200,
        name: "Tata Lite Free Flow Iodised Salt 1 kg",
        quantity: 1,
        discount: 30,
        maxQuantity: 1),
    CartItem(
        image: "assets/images/products/product3.png",
        category: "Groccery",
        price: 121.0,
        name: "Good Life Tur Dal 1 kg",
        quantity: 5,
        discount: 20,
        maxQuantity: 20),
    CartItem(
        image: "assets/images/products/product4.png",
        category: "Groccery",
        price: 123,
        name: "Good Life Almonds 500 g",
        quantity: 1,
        discount: 15,
        maxQuantity: 10),
    CartItem(
        image: "assets/images/products/product2.png",
        category: "Groccery",
        price: 200,
        name: "Tata Lite Free Flow Iodised Salt 1 kg",
        quantity: 1,
        discount: 30,
        maxQuantity: 1),
    CartItem(
        image: "assets/images/products/product1.png",
        category: "Groccery",
        price: 12,
        name: "Aashirvaad Multigrain Atta 5 kg",
        quantity: 1,
        discount: 10,
        maxQuantity: 5),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: appBarIconButton(
                imagePath: "assets/icons/left-arrow.png",
                color: Colors.white,
                onPressed: () => Navigator.pop(context)),
            title: Text("Cart",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white)),
            centerTitle: false,
            backgroundColor: Myapp.primaryColor),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 85),
            child: Column(children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.grey[100],
                  width: size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                            text: "Deliver to\t\t",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: "394221",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))
                            ]),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return card(cartItems[index]);
                },
                separatorBuilder: (_, index) {
                  return Divider(
                    color: Colors.grey,
                  );
                },
                itemCount: cartItems.length,
                shrinkWrap: true,
              ),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[100],
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Apply Coupon",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    RichText(
                        text: TextSpan(
                            text: "Log in",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: " to see best offers and cashback deals",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500))
                        ])),
                    Container(
                      color: Colors.blue,
                      width: 48,
                      height: 2,
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[100],
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Payment Details",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    amountRow(title: "MRP Total", amount: "900.00"),
                    Divider(color: Colors.grey),
                    amountRow(title: "Product Discount", amount: "-90.00"),
                    Divider(color: Colors.grey),
                    amountRow(
                        title: "Total Amount",
                        amount: "810.00",
                        titleColor: Colors.black,
                        amountColor: Colors.black),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("You Save \u20b9232.00",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green)),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[100],
              ),
            ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.symmetric(horizontal: BorderSide(color: Colors.grey))),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 75,
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Payable Amount",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  Text("\u20b94603.00",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ],
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: FlatButton(
                  child: Text("Place Order",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  color: Myapp.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                ),
              ))
            ],
          ),
        ));
  }

  Widget amountRow(
      {String title, String amount, Color titleColor, Color amountColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title ?? "N/A",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: titleColor ?? Colors.grey)),
        Text("\u20b9$amount",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: amountColor ?? Colors.black87)),
      ],
    );
  }

  Widget card(CartItem item) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            item.image,
            width: 70,
            height: 70,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                      text:
                          "\u20b9${(item.price * item.quantity) - (item.quantity * item.discount)}\t\t",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: "\u20b9${item.price * item.quantity}",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "\t\tYou Save \u20b9${item.discount * item.quantity}",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: FlatButton(
                        child: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          if (item.quantity != 1) {
                            setState(() {
                              item.quantity--;
                            });
                          } else {
                            setState(() {
                              cartItems.remove(item);
                            });
                          }
                        },
                        color: Myapp.primaryColor,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      item.quantity.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: FlatButton(
                        child: Icon(Icons.add, color: Colors.white),
                        onPressed: item.quantity <= item.maxQuantity
                            ? () {
                                if (item.quantity != item.maxQuantity) {
                                  setState(() {
                                    item.quantity++;
                                  });
                                }
                              }
                            : () {},
                        color: item.quantity >= item.maxQuantity
                            ? Myapp.primaryColor.withOpacity(0.7)
                            : Myapp.primaryColor,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CartItem {
  final String image, name, category;
  final double price, maxQuantity, discount;
  int quantity;

  CartItem(
      {this.image,
      this.name,
      this.category,
      this.price,
      this.maxQuantity,
      this.discount,
      this.quantity});
}
