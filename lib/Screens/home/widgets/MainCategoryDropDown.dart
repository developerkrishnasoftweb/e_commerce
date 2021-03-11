import 'package:e_commerce/Models/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MainCategoryDropDown extends StatefulWidget {
  List<dynamic> list;
  int subCatIndex;
  Function(int x) onTap;

  MainCategoryDropDown(this.list, this.subCatIndex, {this.onTap});

  @override
  _MainCategoryDropDownState createState() => _MainCategoryDropDownState();
}

class _MainCategoryDropDownState extends State<MainCategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100.sp,
        height: 60.sp,
        color: Colors.white,
        child: FlatButton(
            color: Colors.grey[100],
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Expanded(
                  child: Text(widget.list.isNotEmpty ? widget.list[widget.subCatIndex].name : "",
                      maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold))),
              Icon(Icons.arrow_drop_down_outlined)
            ]),
            onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => BottomSheet(
                    onClosing: () {},
                    builder: (_) {
                      return Column(children:[
                        SizedBox(height: 50.sp),
                        ListTile(
                            title: Text("Category", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                            trailing: IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context), splashRadius: 25)),
                        Expanded(
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                separatorBuilder: (_, index) => Divider(color: Colors.grey),
                                itemBuilder: (_, index) {
                                  return ListTile(
                                    leading: Image.network(
                                        widget.list != null ? URLS.PAL_IMAGE_URL + widget.list[index].image : URLS.EMPTY_IMAGE_URL,
                                        width: 40.sp,
                                        height: 40.sp),
                                    title: Text(widget.list != null ? widget.list[index].name : "Fruits & Vegetables",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
                                    onTap: () => widget.onTap(index),
                                  );
                                },
                                itemCount: widget.list != null ? widget.list.length : 10))
                      ]);
                    },
                    backgroundColor: Colors.white,
                    enableDrag: true))));
  }
}
