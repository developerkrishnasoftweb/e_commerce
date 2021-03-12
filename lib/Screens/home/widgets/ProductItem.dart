import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/ProductsById.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../main.dart';
import '../../ProductDetail.dart';

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

  setItemLoading (Products item, bool status) {
    setState(() {
      item.isLoading = status;
    });
  }

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
                                text: "\u20b9${item.price * item.quantity}\t",
                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: "\u20b9${item.attributes.specialPrice}",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "\t\tYou Save \u20b9${double.parse(item.attributes.specialPrice) * item.quantity}",
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
                                        onPressed: () => _removeItemQuantity(item),
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
                                        onPressed: () => _addItemQuantity(item),
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
                                        child: item.isLoading
                                            ? SizedBox(height: 25, width: 25, child: CircularProgressIndicator(strokeWidth: 2))
                                            : Text("ADD", style: TextStyle(color: Colors.white)),
                                        onPressed: item.isLoading ? null : () => _addToCart(item),
                                        color: Myapp.primaryColor)))
                      ])))
            ])));
  }

  void _addToCart(Products item) async {
    setItemLoading(item, true);
    int quantity = await ApiService.getProductQuantity(item.id.toString());
    if (quantity != null) {
      if (quantity > 0) {
        ResponseData responseData = await ApiService.generateToken({"username": "i@gmail.com", "password": "Abc@123456"});
        if(responseData.status) {
          ResponseData cartId = await ApiService.cartId(responseData.token);
          if(cartId.status) {
            Map<String, dynamic> bodyData = {
              "cartItem" : {
                "sku": item.sku,
                "qty": item.quantity,
                "quote_id": int.parse(cartId.data.toString())
              }
            };
            ResponseData cartStatus = await ApiService.addToCart(bodyData, responseData.token);
            if(cartStatus.status) {
              setState(() {
                item.maxQuantity = quantity;
              });
              setItemLoading(item, false);
              setState(() => item.inCart = true);
            } else {
              setItemLoading(item, false);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(cartStatus.message)));
            }
          } else {
            setItemLoading(item, false);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(cartId.message)));
          }
        } else {
          setItemLoading(item, false);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseData.message)));
        }
      } else {
        setItemLoading(item, false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Sorry, Product is out of stock")));
      }
    } else {
      setItemLoading(item, false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something went wrong please try again later")));
    }
  }

  _removeItemQuantity(Products item) => setState(() => item.quantity != 1 ? item.quantity-- : item.inCart = false);

  _addItemQuantity(Products item) {
    if (item.quantity <= item.maxQuantity) {
      if (item.quantity != item.maxQuantity) {
        setState(() => item.quantity++);
      }
    }
  }
}
