import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Screens/home/widgets/DeliverAddressTop.dart';
import 'package:e_commerce/Screens/home/widgets/FilterButton.dart';
import 'package:e_commerce/Screens/home/widgets/MainCategoryDropDown.dart';
import 'package:e_commerce/Screens/home/widgets/ProductItem.dart';
import 'package:e_commerce/Screens/home/widgets/SubCategoryHorizontalList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TopCategoryDetails extends StatefulWidget {
  List<Categories> list;
  int id;

  TopCategoryDetails({this.list, this.id});

  @override
  _TopCategoryDetailsState createState() => _TopCategoryDetailsState();
}

class _TopCategoryDetailsState extends State<TopCategoryDetails> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var subCatIndex = 0;
  var subCatIndex1 = 0;
  final Map<String, dynamic> bodyData = new Map<String, dynamic>();
  Map<String, dynamic> filterDataPost;

  @override
  void initState() {
    super.initState();
    subCatIndex = widget.id ?? 1;
    subCatIndex1 = 0;
    bodyData['category_id'] = widget.list[subCatIndex].subCategories[subCatIndex1].id.toString();
    bodyData['filters'] = null;
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    widget.list[subCatIndex].subCategories.forEach((element) => setState(() => element.isSelected = false));
    widget.list[subCatIndex].subCategories[subCatIndex1].isSelected = true;

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
                        onTap: (index) =>
                            setState(() {
                              subCatIndex = index;
                              subCatIndex1 = 0;
                              Navigator.of(context).pop();
                              bodyData['category_id'] = widget.list[subCatIndex].subCategories[subCatIndex1].id.toString();
                              bodyData['filters'] = null;
                            })),
                    Expanded(
                        child: SubCategoryHorizontalList(widget.list[subCatIndex].subCategories, onTap: (index) {
                          widget.list[subCatIndex].subCategories.forEach((element) => setState(() => element.isSelected = false));
                          setState(() {
                            subCatIndex1 = index;
                            widget.list[subCatIndex].subCategories[index].isSelected = true;
                            bodyData['category_id'] = widget.list[subCatIndex].subCategories[subCatIndex1].id.toString();
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
                        onApplyFilter: (filterData) =>
                            setState(() {
                              filterDataPost = filterData;
                              bodyData['category_id'] = widget.list[subCatIndex].subCategories[subCatIndex1].id.toString();
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
        actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})]
    );
  }
}
