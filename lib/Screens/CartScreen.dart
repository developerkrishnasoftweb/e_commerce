import 'package:flutter/material.dart';

import '../main.dart';
import 'NavigationDrawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(
        image:
            "https://www.jiomart.com/images/product/75x75/590122516/fortune-health-physically-refined-rice-bran-oil-5-l-india-gate-feast-rozzana-basmati-rice-5-kg-combo-pack-0-20201229.jpg",
        category: "Groccery",
        price: 12,
        name: "Aashirvaad Multigrain Atta 5 kg",
        quantity: 1,
        discount: 10,
        maxQuantity: 5),
    CartItem(
        image:
            "https://www.jiomart.com/images/product/75x75/491504124/super-sarvottam-physicaly-refined-100-rice-bran-oil-1-l-pouch-0-20201021.jpg",
        category: "Groccery",
        price: 200,
        name: "Tata Lite Free Flow Iodised Salt 1 kg",
        quantity: 1,
        discount: 30,
        maxQuantity: 1),
    CartItem(
        image:
            "https://www.jiomart.com/images/product/75x75/491076026/oleev-active-ricebran-based-blended-oil-5-l-jar-0-20200825.jpg",
        category: "Groccery",
        price: 121.0,
        name: "Good Life Tur Dal 1 kg",
        quantity: 5,
        discount: 20,
        maxQuantity: 20),
    CartItem(
        image:
            "https://www.jiomart.com/images/product/75x75/491278308/priya-fortified-with-vitamin-a-d-refined-sunflower-oil-1-l-0-20210119.jpg",
        category: "Groccery",
        price: 123,
        name: "Good Life Almonds 500 g",
        quantity: 1,
        discount: 15,
        maxQuantity: 10),
    CartItem(
        image:
            "https://www.jiomart.com/images/product/75x75/491076025/oleev-active-ricebran-based-blended-oil-1-l-pouch-0-20200805.jpg",
        category: "Groccery",
        price: 200,
        name: "Tata Lite Free Flow Iodised Salt 1 kg",
        quantity: 1,
        discount: 30,
        maxQuantity: 1),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.sp,
          title: Text("My Cart", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})],
        ),
        // leading: IconButton(icon: ImageIcon(AssetImage("assets/icons/left-arrow.png"), color: Colors.white))),
        drawer: navigationDrawer(),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80),
            child: Column(children: [
              GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      color: Colors.grey[100],
                      width: size.width,
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.location_on_rounded, color: Colors.grey),
                        SizedBox(width: 10),
                        RichText(
                            text: TextSpan(
                                text: "Deliver to\t\t",
                                style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: "394221",
                                      style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))
                                ]),
                            textAlign: TextAlign.center)
                      ]))),
              SizedBox(height: 10),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => card(cartItems[index]),
                  separatorBuilder: (_, index) => Divider(color: Colors.grey, endIndent: 20, indent: 20),
                  itemCount: cartItems.length,
                  shrinkWrap: true),
              greyStrip(),
              Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child:
                      Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text("Apply Coupon", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    RichText(
                        text: TextSpan(
                            text: "Log in",
                            style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: " to see best offers and cashback deals",
                              style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500))
                        ])),
                    Container(color: Colors.blue, width: 48, height: 2)
                  ])),
              greyStrip(),
              Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child:
                      Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text("Payment Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    amountRow(title: "MRP Total", amount: "900.00"),
                    Divider(color: Colors.grey),
                    amountRow(title: "Product Discount", amount: "-90.00"),
                    Divider(color: Colors.grey),
                    amountRow(title: "Total Amount", amount: "810.00", titleColor: Colors.black, amountColor: Colors.black),
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text("You Save \u20b9232.00",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)))
                  ])),
              greyStrip()
            ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            decoration: BoxDecoration(color: Colors.white, border: Border.symmetric(horizontal: BorderSide(color: Colors.grey))),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 75,
            child: Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                    Text("Payable Amount", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("\u20b94603.00", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))
                  ])),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: FlatButton(
                          child: Text("Place Order", style: TextStyle(color: Colors.white, fontSize: 18)),
                          onPressed: () {},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                          color: Myapp.primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15))))
            ])));
  }

  Widget amountRow({String title, String amount, Color titleColor, Color amountColor}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title ?? "N/A", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: titleColor ?? Colors.grey)),
      Text("\u20b9$amount", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: amountColor ?? Colors.black87))
    ]);
  }

  Widget card(CartItem item) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.network(item.image, width: 70, height: 70, fit: BoxFit.contain),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(item.name,
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10),
                    RichText(
                        text: TextSpan(
                            text: "\u20b9${(item.price * item.quantity) - (item.quantity * item.discount)}\t\t",
                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: "\u20b9${item.price * item.quantity}",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "\t\tYou Save \u20b9${item.discount * item.quantity}",
                              style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold))
                        ])),
                    SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: FlatButton(
                              child: Icon(Icons.remove, color: Colors.white),
                              onPressed: () {
                                if (item.quantity != 1) {
                                  setState(() => item.quantity--);
                                } else {
                                  setState(() => cartItems.remove(item));
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
                                  : () {},
                              color: item.quantity >= item.maxQuantity ? Myapp.primaryColor.withOpacity(0.7) : Myapp.primaryColor,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))))
                    ])
                  ])))
        ]));
  }

  Widget greyStrip() {
    return Container(height: 25, width: double.infinity, color: Color.fromRGBO(0, 0, 0, 0.2));
  }
}

class CartItem {
  final String image, name, category;
  final double price, maxQuantity, discount;
  int quantity;

  CartItem({this.image, this.name, this.category, this.price, this.maxQuantity, this.discount, this.quantity});
}
