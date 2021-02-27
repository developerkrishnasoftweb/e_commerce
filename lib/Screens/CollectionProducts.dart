import 'package:e_commerce/Models/MainCategory.dart';
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

  List<Item> items = [
    Item(
        image:
            "https://www.jiomart.com/images/product/75x75/590122516/fortune-health-physically-refined-rice-bran-oil-5-l-india-gate-feast-rozzana-basmati-rice-5-kg-combo-pack-0-20201229.jpg",
        category: "Groccery",
        price: 12,
        name: "Aashirvaad Multigrain Atta 5 kg",
        quantity: 1,
        discount: 10,
        maxQuantity: 5),
    Item(
        image:
            "https://www.jiomart.com/images/product/75x75/491504124/super-sarvottam-physicaly-refined-100-rice-bran-oil-1-l-pouch-0-20201021.jpg",
        category: "Groccery",
        price: 200,
        name: "Tata Lite Free Flow Iodised Salt 1 kg",
        quantity: 1,
        discount: 30,
        maxQuantity: 1),
    Item(
        image:
            "https://www.jiomart.com/images/product/75x75/491076026/oleev-active-ricebran-based-blended-oil-5-l-jar-0-20200825.jpg",
        category: "Groccery",
        price: 121.0,
        name: "Good Life Tur Dal 1 kg",
        quantity: 5,
        discount: 20,
        inCart: true,
        maxQuantity: 20),
    Item(
        image:
            "https://www.jiomart.com/images/product/75x75/491278308/priya-fortified-with-vitamin-a-d-refined-sunflower-oil-1-l-0-20210119.jpg",
        category: "Groccery",
        price: 123,
        name: "Good Life Almonds 500 g",
        quantity: 1,
        discount: 15,
        maxQuantity: 10),
    Item(
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
        key: scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 50.sp,
          title: Text("Product", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})],
        ),
        body: Container(
            child: Column(children: [
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (_, index) => Divider(color: Colors.grey, indent: 20, endIndent: 20),
                  itemBuilder: (_, index) => card(items[index]),
                  itemCount: items.length))
        ])));
  }

  Widget card(Item item) {
    return GestureDetector(
       // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetail(item))),
        child: Container(
            padding: EdgeInsets.all(20),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.network(item.image,
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
                                        color: item.quantity >= item.maxQuantity
                                            ? Myapp.primaryColor.withOpacity(0.7)
                                            : Myapp.primaryColor,
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
                                          scaffoldKey.currentState
                                              .showSnackBar(SnackBar(content: Text("Added to cart successfully")));
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

