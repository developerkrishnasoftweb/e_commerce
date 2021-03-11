import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class ChildSubCategoryHorizontalList extends StatefulWidget {
  List<dynamic> childSubCategoryList;
  Function(int index) onPressed;

  ChildSubCategoryHorizontalList(this.childSubCategoryList, {this.onPressed});

  @override
  _ChildSubCategoryHorizontalListState createState() => _ChildSubCategoryHorizontalListState();
}

class _ChildSubCategoryHorizontalListState extends State<ChildSubCategoryHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 5),
        child: ListView.builder(
            itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(left: index == 0 ? 10 : 0, right: 10),
                child: FlatButton(
                    onPressed: () => widget.onPressed(index),
                    child: Text(widget.childSubCategoryList[index].name,
                        style: TextStyle(color: widget.childSubCategoryList[index].isSelected ? Colors.white : Colors.black)),
                    color: widget.childSubCategoryList[index].isSelected ? Myapp.primaryColor : Colors.grey[300])),
            physics: BouncingScrollPhysics(),
            itemCount: widget.childSubCategoryList.length,
            scrollDirection: Axis.horizontal));
  }
}
