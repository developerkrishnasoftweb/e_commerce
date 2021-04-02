import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:flutter/material.dart';

import 'CartScreen.dart';
import 'home/ProductList.dart';
import 'NavigationDrawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopByCategoryScreen extends StatefulWidget {
  @override
  _ShopByCategoryScreenState createState() => _ShopByCategoryScreenState();
}

class _ShopByCategoryScreenState extends State<ShopByCategoryScreen> {
  AllCategory mainCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text("Shop by Category", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen())))
            ]),
        // leading: IconButton(icon: ImageIcon(AssetImage("assets/icons/left-arrow.png"), color: Colors.white))),
        drawer: NavigationDrawer(),
        body: FutureBuilder(
            future: Future.wait([ApiService.getHomeCategories()]),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                throw (snapshot.error);
              }
              if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                mainCategory = snapshot.data[0];
                return ListView.builder(
                    itemCount: mainCategory.data.length,
                    itemBuilder: (context, i) {
                      return ExpansionTile(
                          title: Row(children: [
                            Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: Image(
                                    image: NetworkImage(URLS.PAL_IMAGE_URL + mainCategory.data[i].image), width: 40.sp, height: 40.sp)),
                            Expanded(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(mainCategory.data[i].name,
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                              Text('',
                                  maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey))
                            ]))
                          ]),
                          children: <Widget>[new Column(children: _buildExpandableContent(mainCategory.data[i].subCategories))]);
                    });
              } else
                return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
            }));
  }

  _buildExpandableContent(List<SubCategotyLIst> subCategories) {
    List<Widget> columnContent = [];
    for (SubCategotyLIst content in subCategories)
      columnContent.add(ExpansionTile(
          title: Row(children: [
            SizedBox(width: 20.sp),
            Padding(
                padding: EdgeInsets.all(10.sp),
                child: Image(image: NetworkImage(URLS.PAL_IMAGE_URL + content.image), width: 40.sp, height: 40.sp)),
            Expanded(child: Text(content.name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black)))
          ]),
          children: <Widget>[Column(children: _buildExpandableContent1(content.childSubCategory, content.id))]));
    return columnContent;
  }

  _buildExpandableContent1(List<ChildSubCategory> childSubCategory, int id) {
    List<Widget> columnContent = [];
    for (var i = 0; i < childSubCategory.length; i++)
      columnContent.add(ListTile(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => ProductList(id: childSubCategory[i].id != 0 ? childSubCategory[i].id : id))),
          dense: true,
          contentPadding: EdgeInsets.only(left: 70.sp, right: 25.sp, top: 0, bottom: 0),
          title: Text(childSubCategory[i].name, style: TextStyle(fontSize: 12.sp)),
          trailing: Icon(Icons.navigate_next)));
    return columnContent;
  }
}
