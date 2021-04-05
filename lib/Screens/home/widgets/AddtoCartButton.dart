
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/constant/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../ProductDetail.dart';

class AddtoCartButton extends StatefulWidget {

  Products item;
  String name;

  AddtoCartButton(this.item, this.name);

  @override
  _AddtoCartButtonState createState() => _AddtoCartButtonState();
}

class _AddtoCartButtonState extends State<AddtoCartButton> {
  @override
  Widget build(BuildContext context) {
    Products item = widget.item;
    return  item.inCart
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
              color: item.quantity >= item.maxQuantity
                  ? Myapp.primaryColor.withOpacity(0.7)
                  : Myapp.primaryColor,
              disabledColor: Myapp.primaryColor.withOpacity(0.7),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))))
    ])
        : FlatButton(
            child: item.isLoading
                ? SizedBox(height: 25, width: 25, child: CircularProgressIndicator(strokeWidth: 2))
                : Text(widget.name, style: TextStyle(color: Colors.white)),
            onPressed: item.isLoading ? null : () => _addToCart(item),
            color: Myapp.primaryColor);
  }

  setItemLoading(Products item, bool status) {
    setState(() {
      item.isLoading = status;
    });
  }

  void _addToCart(Products item) async {
    setItemLoading(item, true);
    int quantity = await ApiService.getProductQuantity(item.id.toString());
    if (quantity != null) {
      if (quantity > 0) {
        ResponseData responseData = await ApiService.generateToken({"username": userdata.email, "password": userdata.password}, getToken: true);
        if (responseData.status) {
          ResponseData cartId = await ApiService.cartId(responseData.token);
          if (cartId.status) {
            Map<String, dynamic> bodyData = {
              "cartItem": {"sku": item.sku, "qty": item.quantity, "quote_id": int.parse(cartId.data.toString())}
            };
            ResponseData cartStatus = await ApiService.addToCart(bodyData, responseData.token);
            if (cartStatus.status) {
              setState(() {
                item.maxQuantity = quantity;
              });
              setItemLoading(item, false);
              setState(() => item.inCart = true);
            } else {
              setItemLoading(item, false);
             // Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetail(item)));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cartStatus.message)));
            }
          } else {
            setItemLoading(item, false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cartId.message)));
          }
        } else {
          setItemLoading(item, false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData.message)));
        }
      } else {
        setItemLoading(item, false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sorry, Product is out of stock")));
      }
    } else {
      setItemLoading(item, false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong please try again later")));
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