import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/home/widgets/ChildSubCategoryHorizontalList.dart';
import 'package:e_commerce/Screens/home/widgets/DeliverAddressTop.dart';
import 'package:e_commerce/Screens/home/widgets/FilterButton.dart';
import 'package:e_commerce/Screens/home/widgets/MainCategoryDropDown.dart';
import 'package:e_commerce/Screens/home/widgets/ProductItem.dart';
import 'package:e_commerce/Screens/home/widgets/SubCategoryHorizontalList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class BannerDetails extends StatefulWidget {
  String id;

  BannerDetails({this.id});

  @override
  _BannerDetailsState createState() => _BannerDetailsState();
}

class _BannerDetailsState extends State<BannerDetails> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var subCatIndex = 0;
  var subCatIndex1 = 0;
  var subCatIndex2 = 0;
  var productCount = '';
  List<MainData> list = [];
  List<Products> productsList = [];
  List<ChildSubCategory> childSubCategoryList = [];
  List<SubCategotyLIst> subCategories = [];
  var productId = 0;
  final Map<String, dynamic> bodyData = new Map<String, dynamic>();
  Map<String, dynamic> filterDataPost;
  var future;

  @override
  void initState() {
    future = Future.wait([ApiService.getSubCategories(widget.id ?? "1605")]);
    super.initState();
    subCatIndex = 0;
    subCatIndex1 = 0;
    subCatIndex2 = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        key: scaffoldKey,
        appBar: appBarMain(),
        body: Container(
          child: FutureBuilder(
              future: future,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                  AllCategory mainCategory = snapshot.data[0];
                  list = mainCategory.data;
                  refresh(true);
                  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(productCount),
                              FilterButton(
                                  id: list != null ? list[subCatIndex].id.toString() : "",
                                  onApplyFilter: (filterData) => setState(() => filterDataPost = filterData))
                            ])),
                    ChildSubCategoryHorizontalList(list[subCatIndex].subCategories.length > 0 ? childSubCategoryList : [],
                        onPressed: (index) {
                      childSubCategoryList.forEach((element) => setState(() => element.isSelected = false));
                      setState(() {
                        subCatIndex2 = index;
                        childSubCategoryList[index].isSelected = true;
                        refresh(false);
                      });
                    }),
                    Expanded(child: ProductItem(bodyData, scaffoldKey))
                  ]);
                } else
                  return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
              }),
        ));
  }

  void refresh(bool isFirstTime) {
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
      bodyData['filters'] = filterDataPost;
    } else {
      setState(() => filterDataPost = null);
    }
  }

  @override
  void didUpdateWidget(covariant BannerDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      bodyData['category_id'] = productId;
      bodyData['filters'] = filterDataPost;
    });
  }

  appBarMain() {
    return AppBar(
        toolbarHeight: 50.sp,
        title: Text("Product", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})]);
  }
}
