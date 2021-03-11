import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Screens/home/widgets/ProductItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ProductList extends StatefulWidget {
  List<Categories> list;
  int id;

  ProductList({this.list, this.id});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, dynamic> bodyData = new Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    bodyData['category_id'] = widget.id.toString();
    bodyData['filters'] = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text("Product", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})]),
        body: ProductItem(bodyData, scaffoldKey));
  }
}
