import 'package:e_commerce/Models/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class SubCategoryHorizontalList extends StatefulWidget {
  List<dynamic> subCategories;
  Function(int x) onTap;

  SubCategoryHorizontalList(this.subCategories, {this.onTap});

  @override
  _SubCategoryHorizontalListState createState() => _SubCategoryHorizontalListState();
}

class _SubCategoryHorizontalListState extends State<SubCategoryHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (_, index) {
          return GestureDetector(
              onTap: () => widget.onTap(index),
              child: Container(
                  margin: EdgeInsets.only(left: index == 0 ? 10 : 0, bottom: 7, top: 7, right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: 120.sp,
                  height: 60.sp,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      border: Border.all(color: widget.subCategories[index].isSelected ? Myapp.primaryColor : Colors.white, width: 2)),
                  child: Row(children: [
                    Image.network(URLS.PAL_IMAGE_URL + widget.subCategories[index].image, height: 30.sp, width: 30.sp),
                    SizedBox(width: 10.sp),
                    Expanded(
                        child: Text(widget.subCategories[index].name,
                            maxLines: 3,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                color: widget.subCategories[index].isSelected ? Myapp.primaryColor : Colors.black)))
                  ])));
        },
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.subCategories.length,
        physics: BouncingScrollPhysics());
  }
}
