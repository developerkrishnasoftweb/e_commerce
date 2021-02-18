import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'category.dart';

class SortBy extends StatefulWidget {
  @override
  _SortByState createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  List<String> sortList = [
    "Top Rated",
    "Price - Low to High",
    "Price - High to Low",
    "Newest First",
    "Discount",
    "Popularity",
    "Trending",
    "Most Ordered",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: appBarIconButton(
                imagePath: "assets/icons/left-arrow.png", color: Colors.white, onPressed: () => Navigator.pop(context)),
            title: Text("Sort By", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
            centerTitle: false,
            backgroundColor: Color(0xff4E72D4)),
        body: ListView.separated(
            separatorBuilder: (_, index) => Divider(height: 1),
            itemBuilder: (_, index) => ListTile(
                title: Text(sortList[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                onTap: () {}),
            itemCount: sortList.length));
  }
}
