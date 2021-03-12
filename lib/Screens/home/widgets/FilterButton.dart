import 'package:e_commerce/Models/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class FilterButton extends StatefulWidget {
  String id;
  Function(Map<String, dynamic>) onApplyFilter;

  FilterButton({this.id, this.onApplyFilter});

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

List<String> filterTabs = ["Popularity", "High to Low", "Low to High", "Discount"];

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) {
                return FutureBuilder(
                    future: Future.wait([ApiService.getFiltersData(widget.id)]),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                        ResponseData filterData = snapshot.data[0];
                        Map<String, dynamic> filter = Map<String, dynamic>();
                        filter = filterData.data;

                        List<dynamic> list = [];
                        List<dynamic> list1 = [];
                        List<bool> selected = [];
                        List<dynamic> value = [];
                        List<dynamic> selectedFilter = [];
                        var filterSelectedIndex = 0;

                        list1 = filter['data'];
                        if (list1.length > 0) {
                          list = filter['data'][0]['option'];
                          value = filter['data'][0]['value'];
                          print("filterData" + value.toString());
                          list.forEach((element) => selected.add(false));
                          selected[filterSelectedIndex] = true;
                          value.forEach((element) {
                            List<bool> selected = [];
                            element.forEach((element1) => selected.add(false));
                            selectedFilter.add(selected);
                          });
                        }

                        return StatefulBuilder(
                            builder: (_, state) => BottomSheet(
                                onClosing: () {},
                                builder: (_) {
                                  return Column(mainAxisSize: MainAxisSize.max, children: [
                                    SizedBox(height: 50),
                                    ListTile(
                                        title: Text("Sort & Filter By", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
                                        trailing:
                                            IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context), splashRadius: 25)),
                                    Container(
                                        height: 45,
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(vertical: 5),
                                        child: ListView.builder(
                                            itemBuilder: (_, index) {
                                              return Container(
                                                  margin: EdgeInsets.only(left: index == 0 ? 10 : 0, right: 10),
                                                  child: FlatButton(
                                                      onPressed: () {},
                                                      child: Text(filterTabs[index]),
                                                      color: Colors.grey[200],
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7), side: BorderSide(color: Colors.grey))));
                                            },
                                            physics: BouncingScrollPhysics(),
                                            itemCount: filterTabs.length,
                                            scrollDirection: Axis.horizontal)),
                                    Expanded(
                                      child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                                flex: 1,
                                                child: ListView.separated(
                                                    separatorBuilder: (_, index) => Divider(height: 0.5, color: Colors.grey),
                                                    shrinkWrap: true,
                                                    itemBuilder: (_, index) {
                                                      return GestureDetector(
                                                          child: Container(
                                                              height: 50,
                                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                                              alignment: Alignment.centerLeft,
                                                              decoration:
                                                                  BoxDecoration(color: selected[index] ? Colors.white : Colors.grey[200]),
                                                              child: Text(list[index].toString())),
                                                          onTap: () => state(() {
                                                                selected.asMap().forEach((i, value) => selected[i] = false);
                                                                selected[index] = true;
                                                                filterSelectedIndex = index;
                                                              }));
                                                    },
                                                    itemCount: list.length > 0 ? list.length : 0,
                                                    physics: BouncingScrollPhysics())),
                                            Flexible(
                                                flex: 2,
                                                child: ListView.separated(
                                                    separatorBuilder: (_, index) => Divider(height: 0.5, color: Colors.grey),
                                                    shrinkWrap: true,
                                                    itemBuilder: (_, index) {
                                                      return CheckboxListTile(
                                                        value: selectedFilter[filterSelectedIndex][index],
                                                        onChanged: (value) =>
                                                            state(() => selectedFilter[filterSelectedIndex][index] = value),
                                                        title: Text(value[filterSelectedIndex][index]['name']),
                                                      );
                                                      // return filter.isMultipleSelection
                                                      //     ? CheckboxListTile(
                                                      //         value: filter.filterItems[index].isSelected,
                                                      //         onChanged: (value) => state(() => filter.filterItems[index].isSelected =
                                                      //             !filter.filterItems[index].isSelected),
                                                      //         title: Text(filter.filterItems[index].title),
                                                      //       )
                                                      //     : RadioListTile<FilterItems>(
                                                      //         value: filter.filterItems[index],
                                                      //         groupValue: filter.filterItem,
                                                      //         title: Text(filter.filterItems[index].title),
                                                      //         onChanged: (value) => state(() => filter.filterItem = value),
                                                      //         controlAffinity: ListTileControlAffinity.trailing);
                                                    },
                                                    itemCount: value.length > 0 ? value[filterSelectedIndex].length : 0,
                                                    physics: BouncingScrollPhysics()))
                                          ]),
                                    ),
                                    Row(mainAxisSize: MainAxisSize.min, children: [
                                      Expanded(
                                          child: Container(
                                              margin: EdgeInsets.only(left: 10, right: 5),
                                              child: FlatButton(
                                                  onPressed: () => state(() => selectedFilter.asMap().forEach((i, value) =>
                                                      selectedFilter[i].asMap().forEach((i1, value1) => selectedFilter[i][i1] = false))),
                                                  child: Text("Clear All", style: TextStyle(color: Myapp.primaryColor)),
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(7),
                                                      side: BorderSide(color: Myapp.primaryColor))))),
                                      Expanded(
                                          child: Container(
                                              margin: EdgeInsets.only(left: 10, right: 5),
                                              child: FlatButton(
                                                  onPressed: () {
                                                    Map<String, dynamic> filterDataPost = Map<String, dynamic>();
                                                    list.asMap().forEach((i, element) {
                                                      List<dynamic> list = [];
                                                      selectedFilter[i].asMap().forEach((index1, element2) {
                                                        if (element2) {
                                                          if (element == "CATEGORY") {
                                                            list.add(value[i][index1]['id']);
                                                          } else if (element == "RANGE") {
                                                            var x = value[i][index1]['name'].toString().split(" - ");
                                                            List<dynamic> rangeArray = [];
                                                            rangeArray.add(x[0]);
                                                            rangeArray.add(x[1]);
                                                            list.add(rangeArray);
                                                          } else {
                                                            list.add(value[i][index1]['name']);
                                                          }
                                                        }
                                                      });
                                                      setState(() => filterDataPost[element] = list);
                                                    });
                                                    print("FilterList" + filterDataPost.toString());
                                                    Navigator.pop(context);
                                                    widget.onApplyFilter(filterDataPost);
                                                  },
                                                  child: Text("Apply Filter", style: TextStyle(color: Colors.white)),
                                                  color: Myapp.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(7),
                                                      side: BorderSide(color: Myapp.primaryColor)))))
                                    ])
                                  ]);
                                },
                                backgroundColor: Colors.white,
                                enableDrag: true));
                      } else {
                        return Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                            child: Container(color: Colors.white, child: Center(child: CircularProgressIndicator())));
                      }
                    });
              });
        },
        label: Text("Sort | Filter"),
        icon: Icon(Icons.filter_alt_outlined, size: 15.sp),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)));
  }
}
