import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/cart_item_model.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/checkout.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'NavigationDrawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartInfo> cartItems = [];
  double totalPayable = 0;
  bool isLoading = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  setLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  getCartItems() async {
    setLoading(true);
    cartItems.clear();
    ResponseData responseData = await ApiService.generateToken(
        {"username": "i@gmail.com", "password": "Abc@123456"});
    if (responseData.status) {
      ResponseData cartData = await ApiService.cart(responseData.token);
      if (cartData.status) {
        for (int i = 0; i < cartData.data.length; i++) {
          ResponseData productInfo =
              await ApiService.skuWiseProduct(cartData.data[i]['sku']);
          if(productInfo.status) {
            setState(() {
              cartItems.add(CartInfo(
                  products: productInfo.data['data'].length > 0 ? Products.fromJson(productInfo.data['data'][0]) : Products(),
                  cartItem: CartItem.fromJson(cartData.data[i])));
            });
          }
        }
        countTotalPayable();
        setLoading(false);
      } else {
        setLoading(false);
      }
    } else {
      setLoading(false);
    }
  }

  countTotalPayable () {
    totalPayable = 0;
    cartItems.forEach((element) {
      totalPayable += (element.cartItem.price * element.cartItem.qty);
    });
  }

  @override
  void initState() {
    super.initState();
    getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text("My Cart",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.white),
                  onPressed: () {})
            ]),
        // leading: IconButton(icon: ImageIcon(AssetImage("assets/icons/left-arrow.png"), color: Colors.white))),
        drawer: navigationDrawer(),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : cartItems.length > 0 ? SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 80),
                child: Column(children: [
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          color: Colors.grey[100],
                          width: size.width,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.location_on_rounded,
                                    color: Colors.grey),
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
                                    textAlign: TextAlign.center)
                              ]))),
                  SizedBox(height: 10),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) => card(cartItems[index]),
                      separatorBuilder: (_, index) => Divider(
                          color: Colors.grey, endIndent: 20, indent: 20),
                      itemCount: cartItems.length,
                      shrinkWrap: true),
                  greyStrip(),
                  Container(
                      width: size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                                      text:
                                          " to see best offers and cashback deals",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500))
                                ])),
                            Container(color: Colors.blue, width: 48, height: 2)
                          ])),
                  greyStrip(),
                  Container(
                      width: size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Payment Details",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            amountRow(
                                title: "MRP Total", amount: "$totalPayable"),
                            Divider(color: Colors.grey),
                            amountRow(
                                title: "Total Amount",
                                amount: "$totalPayable",
                                titleColor: Colors.black,
                                amountColor: Colors.black),
                            SizedBox(height: 10),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text("You Save \u20b90.00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.green)))
                          ])),
                ])) : Center(child: Text("Your cart is empty!!!")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: totalPayable != 0 ? isLoading
            ? null
            : Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.grey))),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 75,
                child: Row(children: [
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
                        Text("\u20b9$totalPayable",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))
                      ])),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: FlatButton(
                              child: Text("Place Order",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => Checkout()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              color: Myapp.primaryColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15))))
                ])) : null);
  }

  Widget amountRow(
      {String title, String amount, Color titleColor, Color amountColor}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title ?? "N/A",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: titleColor ?? Colors.grey)),
      Text("\u20b9$amount",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: amountColor ?? Colors.black87))
    ]);
  }

  Widget card(CartInfo item) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.network(URLS.PAL_IMAGE_URL + "/pub/media/catalog/product" + (item.products.images != null ? item.products.images[0].file : ""),
              width: 70, height: 70, fit: BoxFit.contain),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.cartItem.name ?? "N/A",
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        SizedBox(height: 10),
                        RichText(
                            text: TextSpan(
                                text: "\u20b9100" + "\t",
                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: "0",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          decoration: TextDecoration.lineThrough,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '\n' + "You Save \u20b9100",
                                      style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold))
                                ])),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: FlatButton(
                                      child: item.isDeleting ? SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2)) : Icon(Icons.remove,
                                          color: Colors.white),
                                      onPressed: item.isDeleting ? null : () => _removeQuantity(item),
                                      color: Myapp.primaryColor,
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)))),
                              SizedBox(width: 10),
                              Text(item.cartItem.qty.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              SizedBox(width: 10),
                              SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: FlatButton(
                                      child: item.isLoading
                                          ? SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2))
                                          : Icon(Icons.add,
                                              color: Colors.white),
                                      onPressed: item.isLoading
                                          ? null
                                          : () => _addToCart(item),
                                      color: Myapp.primaryColor,
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))))
                            ])
                      ])))
        ]));
  }

  void _addToCart(CartInfo item) async {
    setState(() {
      item.isLoading = true;
    });
    int quantity =
        await ApiService.getProductQuantity(item.cartItem.sku.toString());
    if (quantity != null) {
      if (quantity > item.cartItem.qty) {
        ResponseData responseData = await ApiService.generateToken({"username": "i@gmail.com", "password": "Abc@123456"});
        if(responseData.status) {
          ResponseData cartId = await ApiService.cartId(responseData.token);
          if(cartId.status) {
            ResponseData updateQuantity = await ApiService.updateCartItemQuantity(token: responseData.token, itemId: item.cartItem.itemId.toString(), qty: (item.cartItem.qty + 1).toString(), quoteId: cartId.data.toString());
            if(updateQuantity.status) {
              setState(() {
                item.cartItem.qty++;
                item.isLoading = false;
              });
            } else {
              setState(() {
                item.isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(updateQuantity.message)));
            }
          } else {
            setState(() => item.isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(cartId.message)));
          }
        } else {
          setState(() => item.isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseData.message)));
        }
        countTotalPayable();
      } else {
        setState(() => item.isLoading = false);
        scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Maximum limit of product has been reached")));
      }
    } else {
      setState(() => item.isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something went wrong, Please try again later")));
    }
  }

  Widget greyStrip() => Container(
      height: 25, width: double.infinity, color: Color.fromRGBO(0, 0, 0, 0.2));

  _removeQuantity(CartInfo item) async {
    setState(() {
      item.isDeleting = true;
    });
    ResponseData responseData = await ApiService.generateToken({"username": "i@gmail.com", "password": "Abc@123456"});
    if (item.cartItem.qty != 1) {
      if(responseData.status) {
        ResponseData cartId = await ApiService.cartId(responseData.token);
        if(cartId.status) {
          ResponseData updateQuantity = await ApiService.updateCartItemQuantity(token: responseData.token, itemId: item.cartItem.itemId.toString(), qty: (item.cartItem.qty - 1).toString(), quoteId: cartId.data.toString());
          if(updateQuantity.status) {
            setState(() {
              item.cartItem.qty--;
              item.isDeleting = false;
            });
          } else {
            setState(() {
              item.isDeleting = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(updateQuantity.message)));
          }
        } else {
          setState(() => item.isDeleting = false);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(cartId.message)));
        }
      } else {
        setState(() => item.isDeleting = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData.message)));
      }
    } else {
      ResponseData deleteCartItem = await ApiService.removeItemFromCart(itemId: item.cartItem.itemId.toString(), token: responseData.token);
      if(deleteCartItem.status) {
        setState(() {
          item.isDeleting = false;
          cartItems.remove(item);
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(deleteCartItem.message)));
      } else {
        setState(() => item.isDeleting = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(deleteCartItem.message)));
      }
    }
    countTotalPayable();
  }
}

class CartInfo {
  final Products products;
  final CartItem cartItem;
  bool isLoading, isDeleting;

  CartInfo({this.products, this.cartItem, this.isLoading: false, this.isDeleting : false});
}


