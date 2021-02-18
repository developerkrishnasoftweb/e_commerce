import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:e_commerce/Models/SubCategories.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/CartScreen.dart';
import 'package:e_commerce/UI/filter_list.dart';
import 'package:e_commerce/UI/products.dart';
import 'package:e_commerce/UI/sort_by.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Category extends StatefulWidget {
  final String categoryId, departmentId;

  Category({this.categoryId, this.departmentId});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: ApiService.getCategories(widget.categoryId, widget.departmentId),
        builder: (context, snapshot) {
          final SubCategory data = snapshot.data;
          print("data" + data.toString());
          if (snapshot.connectionState == ConnectionState.done && data != null) {
            return DefaultTabController(
                length: data.data.subCategories.length,
                child: Scaffold(
                    appBar: AppBar(
                        elevation: 0,
                        leading: appBarIconButton(
                            imagePath: "assets/icons/left-arrow.png", onPressed: () => Navigator.pop(context)),
                        title: Text(
                          data.data.title ?? "Category",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                        ),
                        centerTitle: false,
                        backgroundColor: Colors.white,
                        actions: [
                          appBarIconButton(imagePath: "assets/icons/loupe.png", onPressed: () {}),
                          appBarIconButton(imagePath: "assets/icons/heart.png", onPressed: () {}),
                          appBarIconButton(
                              imagePath: "assets/icons/shopping-cart.png",
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen())))
                        ],
                        bottom: TabBar(
                            isScrollable: true,
                            tabs: data.data.subCategories.map((e) {
                              return Tab(
                                  child: Text(e.title,
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
                            }).toList())),
                    backgroundColor: Colors.grey[100],
                    body: data.data.subCategories.isNotEmpty
                        ? Column(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.max, children: [
                            Expanded(
                                child: TabBarView(
                                    children: List<Widget>.generate(data.data.subCategories.length, (int index) {
                              return GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: (size.width * 0.2/ 100.h),
                                      mainAxisSpacing: 10),
                                  itemCount: data.data.subCategories[index].brands.length,
                                  padding: EdgeInsets.only(top: 0, bottom: 10, left:10, right: 10),
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index1) {
                                    return GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ProductScreen(
                                                    manufacturerId: data.data.subCategories[index].brands[index1].id.toString(),
                                                    subCategoryId: data.data.subCategories[index].id.toString(),
                                                    title: data.data.subCategories[index].brands[index1].title))),
                                        child: Column(children: [
                                          AspectRatio(
                                            aspectRatio: 1 / 1,
                                            child: Image(
                                                image:
                                                // data.data.subCategories[index].brands[index1].image.isEmpty ?
                                                    AssetImage("assets/logo.jpeg")
                                                // : NetworkImage(URLS.IMAGE_URL + widget.childrenData[index].childrenData[index1].image)
                                                ,
                                                fit: BoxFit.contain),
                                          ),
                                          Align(
                                              alignment: Alignment.center,
                                              child: Text(data.data.subCategories[index].brands[index1].title,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))
                                        ]));
                                  });
                            }))),
                            Container(
                                height: 80,
                                width: size.width,
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Row(children: [
                                  Expanded(
                                      child: FlatButton.icon(
                                          onPressed: () =>
                                              Navigator.push(context, MaterialPageRoute(builder: (_) => SortBy())),
                                          icon: ImageIcon(AssetImage("assets/icons/sort.png")),
                                          label: Text("SORT", style: TextStyle(color: Colors.black)),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              side: BorderSide(color: Colors.black)),
                                          padding: EdgeInsets.symmetric(vertical: 16))),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: FlatButton.icon(
                                          onPressed: () =>
                                              Navigator.push(context, MaterialPageRoute(builder: (_) => FilterList())),
                                          icon: ImageIcon(AssetImage("assets/icons/education.png")),
                                          label: Text("FILTER", style: TextStyle(color: Colors.black)),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              side: BorderSide(color: Colors.black)),
                                          padding: EdgeInsets.symmetric(vertical: 16)))
                                ]))
                          ])
                        : Container(
                            color: Colors.white,
                            child: Center(
                                child: Text("Data not found!",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal))))));
          } else
            return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
        });
  }
}

IconButton appBarIconButton({@required String imagePath, @required VoidCallback onPressed, Color color}) {
  return IconButton(
      onPressed: onPressed, splashRadius: 25, icon: ImageIcon(AssetImage(imagePath), color: color ?? Colors.black));
}
