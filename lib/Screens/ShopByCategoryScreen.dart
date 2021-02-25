import 'package:flutter/material.dart';

import 'CartScreen.dart';
import 'NavigationDrawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopByCategoryScreen extends StatefulWidget {
  @override
  _ShopByCategoryScreenState createState() => _ShopByCategoryScreenState();
}

class _ShopByCategoryScreenState extends State<ShopByCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shop by Category", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                })
          ],
        ),
        // leading: IconButton(icon: ImageIcon(AssetImage("assets/icons/left-arrow.png"), color: Colors.white))),
        drawer: navigationDrawer(),
        body: ListView.builder(
          itemCount: categoryItem.length,
          itemBuilder: (context, i) {
            return ExpansionTile(
                title: Row(children: [
                  Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Image(image: NetworkImage(categoryItem[i].image), width: 40.sp, height: 40.sp)),
                  Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(categoryItem[i].title,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                    Text(categoryItem[i].description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.sp, color: Colors.blueGrey))
                  ]))
                ]),
                children: <Widget>[new Column(children: _buildExpandableContent(categoryItem[i].subCategoryItem))]);
          },
        ));
  }

  _buildExpandableContent(List<SubCategoryItem> subCategoryItem) {
    List<Widget> columnContent = [];
    for (SubCategoryItem content in subCategoryItem)
      columnContent.add(ExpansionTile(
          title: Row(children: [
            Padding(
                padding: EdgeInsets.all(10.sp),
                child: Image(image: NetworkImage(content.image), width: 40.sp, height: 40.sp)),
            Expanded(
                child: Text(content.title,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black)))
          ]),
          children: <Widget>[Column(children: _buildExpandableContent1())]));
    return columnContent;
  }

  _buildExpandableContent1() {
    List<Widget> columnContent = [];
    for (var i = 0; i < 5; i++)
      columnContent.add(
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 25.sp, right: 25.sp, top: 0, bottom: 0),
          title: Text("Fresh Fruits", style: TextStyle(fontSize: 12.sp)),
          trailing: Icon(Icons.navigate_next),
        ),
      );
    return columnContent;
  }
}

List<CategoryItem> categoryItem = [
  CategoryItem(
      "Groceries",
      "https://cdn2.iconfinder.com/data/icons/grocery-store-solid/64/Grocery_food-36-512.png",
      'Fruits & Vegetables, Dairy & Bakery, Staples, Snacks & Branded Foods, Beverages, '
          'Personal Care, Home Care, Baby Care, Best Deals, Home & Kitchen',
      [
        SubCategoryItem(
            "Fruits & Vegetables", 'https://www.jiomart.com/images/category/141/thumb/fruits-vegetables-20200520.png'),
        SubCategoryItem('Dairy & Bakery', 'https://www.jiomart.com/images/category/12/thumb/0-12.png'),
        SubCategoryItem('Staples', 'https://www.jiomart.com/images/category/13/thumb/staples-20200710.jpg'),
        SubCategoryItem('Snacks & Branded Foods', 'https://www.jiomart.com/images/category/11/thumb/0-11.png'),
      ]),
  CategoryItem('Fashion', 'https://cdn1.iconfinder.com/data/icons/fashion-line-1/55/dress__cloth__fashion_-512.png',
      'Men, Women, Boys, Girls, Junior Boys, Junior Girls, Infants, Toys & Baby Care, Home & Kitchen', [
    SubCategoryItem("Men", 'https://www.jiomart.com/images/category/496/thumb/men-20200808.jpg'),
    SubCategoryItem("Women", 'https://www.jiomart.com/images/category/493/thumb/women-20200808.jpg'),
    SubCategoryItem("Boys", 'https://www.jiomart.com/images/category/499/thumb/boys-20200808.jpg')
  ]),
  CategoryItem('Jewellery', 'https://static.thenounproject.com/png/1451484-200.png', 'Fine Jewellery', [
    SubCategoryItem("Fine Jewellery", 'https://www.jiomart.com/images/category/1531/thumb/fine-jewellery-20201127.png')
  ])
];

class CategoryItem {
  String title, image, description;
  List<SubCategoryItem> subCategoryItem;

  CategoryItem(this.title, this.image, this.description, this.subCategoryItem);
}

class SubCategoryItem {
  String title, image;

  SubCategoryItem(this.title, this.image);
}
