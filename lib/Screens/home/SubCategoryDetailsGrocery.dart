import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Screens/home/widgets/DeliverAddressTop.dart';
import 'package:e_commerce/Screens/home/widgets/FilterButton.dart';
import 'package:e_commerce/Screens/home/widgets/MainCategoryDropDown.dart';
import 'package:e_commerce/Screens/home/widgets/ProductItem.dart';
import 'package:e_commerce/Screens/home/widgets/SubCategoryHorizontalList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SubCategoryDetailsGrocery extends StatefulWidget {
  List<SubCategotyLIst> list;
  int id;

  SubCategoryDetailsGrocery({this.list, this.id});

  @override
  _SubcategoryDetailsState createState() => _SubcategoryDetailsState();
}

class _SubcategoryDetailsState extends State<SubCategoryDetailsGrocery> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var subCatIndex = 0;
  var subCatIndex1 = 0;
  final Map<String, dynamic> bodyData = new Map<String, dynamic>();
  Map<String, dynamic> filterDataPost;

  @override
  void initState() {
    super.initState();
    subCatIndex = widget.id ?? 0;
    subCatIndex1 = 0;
    bodyData['category_id'] = getProductId();
    bodyData['filters'] = null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    widget.list[subCatIndex].childSubCategory.forEach((element) => setState(() => element.isSelected = false));
    widget.list[subCatIndex].childSubCategory[subCatIndex1].isSelected = true;

    return Scaffold(
        key: scaffoldKey,
        appBar: appBarMain(),
        body: Container(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          DeliverAddressTo(),
          Container(
              height: 60.sp,
              width: size.width,
              color: Colors.grey[100],
              child: Row(children: [
                MainCategoryDropDown(widget.list, subCatIndex,
                    onTap: (index) => setState(() {
                          subCatIndex = index;
                          subCatIndex1 = 0;
                          Navigator.of(context).pop();
                          bodyData['category_id'] = getProductId();
                          bodyData['filters'] = null;
                        })),
                Expanded(
                    child: SubCategoryHorizontalList(widget.list[subCatIndex].childSubCategory, onTap: (index) {
                  widget.list[subCatIndex].childSubCategory.forEach((element) => setState(() => element.isSelected = false));
                  setState(() {
                    subCatIndex1 = index;
                    widget.list[subCatIndex].childSubCategory[index].isSelected = true;
                    bodyData['category_id'] = getProductId();
                    bodyData['filters'] = null;
                  });
                })),
              ])),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.grey[300],
              width: size.width,
              height: 40,
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("5 products"),
                FilterButton(
                    id: widget.list != null ? widget.list[subCatIndex].id.toString() : "",
                    onApplyFilter: (filterData) => setState(() {
                          filterDataPost = filterData;
                          bodyData['category_id'] = getProductId();
                          bodyData['filters'] = filterDataPost;
                        }))
              ])),
          Expanded(child: ProductItem(bodyData, scaffoldKey))
        ])));
  }

  appBarMain() {
    return AppBar(
      toolbarHeight: 50.sp,
      title: Text("Product", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
      actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})],
    );
  }

  getProductId() {
    return widget.list[subCatIndex].childSubCategory[subCatIndex1].id == 0
        ? widget.list[subCatIndex].id.toString()
        : widget.list[subCatIndex].childSubCategory[subCatIndex1].id.toString();
  }
}

