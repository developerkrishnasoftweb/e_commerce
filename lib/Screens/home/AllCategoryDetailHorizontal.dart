import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/ProductsById.dart';
import 'package:e_commerce/Screens/home/widgets/ChildSubCategoryHorizontalList.dart';
import 'package:e_commerce/Screens/home/widgets/DeliverAddressTop.dart';
import 'package:e_commerce/Screens/home/widgets/FilterButton.dart';
import 'package:e_commerce/Screens/home/widgets/MainCategoryDropDown.dart';
import 'package:e_commerce/Screens/home/widgets/ProductItem.dart';
import 'package:e_commerce/Screens/home/widgets/SubCategoryHorizontalList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AllCategoryDetailHorizontal extends StatefulWidget {
  List<MainData> list;
  int id;

  AllCategoryDetailHorizontal({this.list, this.id});

  @override
  _AllCategoryDetailHorizontalState createState() => _AllCategoryDetailHorizontalState();
}

class _AllCategoryDetailHorizontalState extends State<AllCategoryDetailHorizontal> {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var subCatIndex = 0;
  var subCatIndex1 = 0;
  var subCatIndex2 = 0;
  var productId = 0;

  List<MainData> list = [];
  List<Products> productsList = [];
  List<ChildSubCategory> childSubCategoryList = [];
  List<SubCategotyLIst> subCategories = [];
  ProductsById products;
  bool productsFound = false;
  final Map<String, dynamic> bodyData = new Map<String, dynamic>();
  Map<String, dynamic> filterDataPost;

  @override
  void initState() {
    super.initState();
    subCatIndex = widget.id ?? 1;
    subCatIndex1 = 0;
    subCatIndex2 = 0;
    list = widget.list;

    refresh(true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                MainCategoryDropDown(list, subCatIndex,
                    onTap: (index) => setState(() {
                          subCatIndex = index;
                          subCatIndex1 = 0;
                          subCatIndex2 = 0;
                          Navigator.of(context).pop();
                          refresh(false);
                        })),
                Expanded(
                    child: SubCategoryHorizontalList(subCategories, onTap: (index) {
                  subCategories.forEach((element) => setState(() => element.isSelected = false));
                  childSubCategoryList.forEach((element) => setState(() => element.isSelected = false));
                  setState(() {
                    subCatIndex1 = index;
                    subCatIndex2 = 0;
                    subCategories[index].isSelected = true;
                    refresh(false);
                  });
                }))
              ])),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.grey[300],
              width: size.width,
              height: 40,
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("0 products"),
                FilterButton(
                    id: list != null ? list[subCatIndex].id.toString() : "",
                    onApplyFilter: (filterData) => setState(() {
                          filterDataPost = filterData;
                          bodyData['category_id'] = productId;
                          bodyData['filters'] = filterDataPost;
                        }))
              ])),
          ChildSubCategoryHorizontalList(list[subCatIndex].subCategories.length > 0 ? childSubCategoryList : [], onPressed: (index) {
            childSubCategoryList.forEach((element) => setState(() => element.isSelected = false));
            setState(() {
              subCatIndex2 = index;
              childSubCategoryList[index].isSelected = true;
              refresh(false);
            });
          }),
          Expanded(child: ProductItem(bodyData, scaffoldKey))
        ])));
  }

  @override
  void didUpdateWidget(covariant AllCategoryDetailHorizontal oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      bodyData['category_id'] = productId;
      bodyData['filters'] = filterDataPost;
    });
  }

  void refresh(bool isFirstTime) {
    print("refresh Call");
    list = widget.list;
    if (list.length > subCatIndex) {
      subCategories = list[subCatIndex].subCategories;
      if (list[subCatIndex].subCategories.length > subCatIndex1) {
        list[subCatIndex].subCategories[subCatIndex1].isSelected = true;
        childSubCategoryList = list[subCatIndex].subCategories[subCatIndex1].childSubCategory;
        if (list[subCatIndex].subCategories[subCatIndex1].childSubCategory.length > subCatIndex2) {
          list[subCatIndex].subCategories[subCatIndex1].childSubCategory[subCatIndex2].isSelected = true;
          productId = list[subCatIndex].subCategories[subCatIndex1].childSubCategory[subCatIndex2].id != 0
              ? list[subCatIndex].subCategories[subCatIndex1].childSubCategory[subCatIndex2].id
              : list[subCatIndex].subCategories[subCatIndex1].id;
        } else {
          productId = 0;
        }
      } else {
        childSubCategoryList = [];
        productId = 0;
      }
    } else {
      childSubCategoryList = [];
      productsList = [];
      subCategories = [];
      productId = 0;
    }

    if (isFirstTime) {
      bodyData['category_id'] = productId;
      bodyData['filters'] = null;
    } else {
      setState(() {
        filterDataPost = null;
        bodyData['category_id'] = productId;
        bodyData['filters'] = filterDataPost;
      });
    }
    print("productId    " + productId.toString());
  }

  appBarMain() {
    return AppBar(
      toolbarHeight: 50.sp,
      title: Text("Product", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
      actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})],
    );
  }
}
