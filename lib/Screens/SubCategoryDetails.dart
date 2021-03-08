import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/ProductsById.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ProductDetail.dart';

class SubcategoryDetails extends StatefulWidget {
  List<Categories> list;
  int id;

  SubcategoryDetails({this.list, this.id});

  @override
  _SubcategoryDetailsState createState() => _SubcategoryDetailsState();
}

class _SubcategoryDetailsState extends State<SubcategoryDetails> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> products = ["ALL", "Exotic Vegetables", "Citrus Fruits", "Root Vegetable", "Beans", "Guard", "Vegetable Others"],
      filterTabs = ["Popularity", "High to Low", "Low to High", "Discount"];

  var subCatIndex = 0;
  var subCatIndex1 = 0;

  @override
  void initState() {
    super.initState();
    subCatIndex = widget.id ?? 1;
    subCatIndex1 = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    widget.list[subCatIndex].subCategories.forEach((element) => setState(() => element.isSelected = false));
    widget.list[subCatIndex].subCategories[subCatIndex1].isSelected = true;

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 50.sp,
          title: Text("Product", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})],
        ),
        body: Container(
            child:
                //     FutureBuilder(
                //      future: Future.wait([ApiService.getSubCategories(widget.id.toString() ?? "1605")]),
                //      builder: (context, AsyncSnapshot snapshot) {
                //        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                //         return
                Column(children: [
          GestureDetector(
              onTap: () {},
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.grey[200],
                  width: size.width,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.location_on_rounded, color: Colors.grey),
                    SizedBox(width: 10),
                    RichText(
                        text: TextSpan(
                            text: "Deliver to\t\t",
                            style: TextStyle(color: Colors.grey, fontSize: 11.sp, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(text: "394221", style: TextStyle(color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.bold))
                            ]),
                        textAlign: TextAlign.center)
                  ]))),
          Container(
              height: 60.sp,
              width: size.width,
              color: Colors.grey[100],
              child: Row(children: [
                Container(
                    width: 100.sp,
                    height: 60.sp,
                    color: Colors.white,
                    child: FlatButton(
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                          Expanded(
                              child: Text(
                            widget.list != null ? widget.list[subCatIndex].name : "Staples",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                          )),
                          Icon(Icons.arrow_drop_down_outlined)
                        ]),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) {
                                return BottomSheet(
                                    onClosing: () {},
                                    builder: (_) {
                                      return Column(children: [
                                        SizedBox(height: 50.sp),
                                        ListTile(
                                            title: Text("Category", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                                            trailing: IconButton(
                                                icon: Icon(Icons.close), onPressed: () => Navigator.pop(context), splashRadius: 25)),
                                        Expanded(
                                            child: ListView.separated(
                                                separatorBuilder: (_, index) => Divider(color: Colors.grey),
                                                itemBuilder: (_, index) {
                                                  return ListTile(
                                                      leading: Image.network(
                                                          widget.list != null
                                                              ? URLS.PAL_IMAGE_URL + widget.list[index].image
                                                              : "https://www.jiomart.com/images/category/141/thumb/fruits-vegetables-20200520.png",
                                                          width: 40.sp,
                                                          height: 40.sp),
                                                      title: Text(widget.list != null ? widget.list[index].name : "Fruits & Vegetables",
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
                                                      // subtitle: Text(
                                                      //   "Fresh Fruits,Fresh Vegetables,Herbs & Season ,Exotic Fruits & Vegetables",
                                                      //   maxLines: 1,
                                                      //   overflow: TextOverflow.ellipsis,
                                                      // ),
                                                      onTap: () => setState(() {
                                                            subCatIndex = index;
                                                            subCatIndex1 = 0;
                                                            Navigator.of(context).pop();
                                                          }));
                                                },
                                                itemCount: widget.list != null ? widget.list.length : 10))
                                      ]);
                                    },
                                    backgroundColor: Colors.white,
                                    enableDrag: true);
                              });
                        },
                        color: Colors.grey[100])),
                Expanded(
                    child: ListView.builder(
                        itemBuilder: (_, index) {
                          return GestureDetector(
                              onTap: () {
                                widget.list[subCatIndex].subCategories.forEach((element) => setState(() => element.isSelected = false));
                                setState(() {
                                  subCatIndex1 = index;
                                  widget.list[subCatIndex].subCategories[index].isSelected = true;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: index == 0 ? 10 : 0, bottom: 7, top: 7, right: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  width: 120.sp,
                                  height: 60.sp,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white,
                                      border: Border.all(
                                          color:
                                              widget.list[subCatIndex].subCategories[index].isSelected ? Myapp.primaryColor : Colors.white,
                                          width: 2)),
                                  child: Row(children: [
                                    Image.network(URLS.PAL_IMAGE_URL + widget.list[subCatIndex].subCategories[index].image,
                                        height: 30.sp, width: 30.sp),
                                    SizedBox(width: 10.sp),
                                    Expanded(
                                        child: Text(widget.list[subCatIndex].subCategories[index].name,
                                            maxLines: 3,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                                color: widget.list[subCatIndex].subCategories[index].isSelected
                                                    ? Myapp.primaryColor
                                                    : Colors.black)))
                                  ])));
                        },
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.list[subCatIndex].subCategories.length,
                        physics: BouncingScrollPhysics()))
              ])),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.grey[300],
              width: size.width,
              height: 40,
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("5 products"),
                FlatButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return FutureBuilder(
                                future: Future.wait(
                                    [ApiService.getFiltersData(widget.list != null ? widget.list[subCatIndex].id.toString() : "")]),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                    ResponseData filterData = snapshot.data[0];
                                    Map<String, dynamic> filter = Map<String, dynamic>();
                                    filter = filterData.data;
                                    List<dynamic> list = List();
                                    List<dynamic> list1 = List();

                                    List<bool> selected = List();
                                    List<dynamic> value = List();
                                    List<dynamic> selectedFilter = List();
                                    var filter_selected_index = 0;

                                    list1 = filter['data'];

                                    if (list1.length > 0) {
                                      list = filter['data'][0]['option'];
                                      value = filter['data'][0]['value'];
                                      print("filterData" + value.toString());

                                      list.forEach((element) => selected.add(false));
                                      selected[filter_selected_index] = true;

                                      value.forEach((element) {
                                        List<bool> selected = List();
                                        element.forEach((element1) {
                                          selected.add(false);
                                        });
                                        selectedFilter.add(selected);
                                      });
                                    }

                                    return StatefulBuilder(
                                        builder: (_, state) => BottomSheet(
                                            onClosing: () {},
                                            builder: (_) {
                                              return Column(children: [
                                                SizedBox(height: 50),
                                                ListTile(
                                                    title: Text("Sort & Filter By",
                                                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
                                                    trailing: IconButton(
                                                        icon: Icon(Icons.close),
                                                        onPressed: () => Navigator.pop(context),
                                                        splashRadius: 25)),
                                                Container(
                                                    height: 45,
                                                    width: size.width,
                                                    padding: EdgeInsets.symmetric(vertical: 5),
                                                    child: ListView.builder(
                                                        itemBuilder: (_, index) {
                                                          return Container(
                                                              margin: EdgeInsets.only(left: index == 0 ? 10 : 0, right: 10),
                                                              child: FlatButton(
                                                                  onPressed: () {},
                                                                  child: Text(filterTabs[index]),
                                                                  color: Colors.grey[200],
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(7),
                                                                      side: BorderSide(color: Colors.grey))));
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
                                                              shrinkWrap: true,
                                                              separatorBuilder: (_, index) => Divider(height: 0.5, color: Colors.grey),
                                                              itemBuilder: (_, index) {
                                                                return GestureDetector(
                                                                    child: Container(
                                                                        height: 50,
                                                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                                                        alignment: Alignment.centerLeft,
                                                                        decoration: BoxDecoration(
                                                                            color: selected[index] ? Colors.white : Colors.grey[200]),
                                                                        child: Text(list[index].toString())),
                                                                    onTap: () {
                                                                      state(() {
                                                                        selected.asMap().forEach((i, value) {
                                                                          selected[i] = false;
                                                                        });
                                                                        selected[index] = true;
                                                                        filter_selected_index = index;
                                                                      });
                                                                    });
                                                              },
                                                              itemCount: list.length > 0 ? list.length : 0,
                                                              physics: BouncingScrollPhysics())),
                                                      Flexible(
                                                          flex: 2,
                                                          child: ListView.separated(
                                                              shrinkWrap: true,
                                                              separatorBuilder: (_, index) => Divider(height: 0.5, color: Colors.grey),
                                                              itemBuilder: (_, index) {
                                                                return CheckboxListTile(
                                                                  value: selectedFilter[filter_selected_index][index],
                                                                  onChanged: (value) => state(() {
                                                                    selectedFilter[filter_selected_index][index] = value;
                                                                  }),
                                                                  title: Text(value[filter_selected_index][index]['name']),
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
                                                              itemCount: value.length > 0 ? value[filter_selected_index].length : 0,
                                                              physics: BouncingScrollPhysics()))
                                                    ])),
                                                Row(mainAxisSize: MainAxisSize.min, children: [
                                                  Expanded(
                                                      child: Container(
                                                          margin: EdgeInsets.only(left: 10, right: 5),
                                                          child: FlatButton(
                                                              onPressed: () {
                                                                state(() {
                                                                  selectedFilter.asMap().forEach((i, value) {
                                                                    selectedFilter[i].asMap().forEach((i1, value1) {
                                                                      selectedFilter[i][i1] = false;
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Text("Clear All", style: TextStyle(color: Myapp.primaryColor)),
                                                              color: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(7),
                                                                  side: BorderSide(color: Myapp.primaryColor))))),
                                                  Expanded(
                                                    child: Container(
                                                        margin: EdgeInsets.only(left: 10, right: 5),
                                                        child: FlatButton(
                                                            onPressed: () {},
                                                            child: Text("Apply Filter", style: TextStyle(color: Colors.white)),
                                                            color: Myapp.primaryColor,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(7),
                                                                side: BorderSide(color: Myapp.primaryColor)))),
                                                  )
                                                ])
                                              ]);
                                            },
                                            backgroundColor: Colors.white,
                                            enableDrag: true));
                                  } else {
                                    return Padding(
                                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                                      child: Container(color: Colors.white, child: Center(child: CircularProgressIndicator())),
                                    );
                                  }
                                });
                          });
                    },
                    label: Text("Sort | Filter"),
                    icon: Icon(Icons.filter_alt_outlined, size: 15.sp),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)))
              ])),
          Visibility(
            visible: false,
            child: Container(
                height: 50,
                width: size.width,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ListView.builder(
                    itemBuilder: (_, index) {
                      return GestureDetector(
                          onTap: () {
                            // widget.list[subCatIndex].subCategories.forEach((element) =>
                            //     setState(() => element.isSelected = false));
                            // setState(() {
                            //   subCatIndex1 = index;
                            //   widget.list[subCatIndex].subCategories[index].isSelected = true;
                            // });
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: index == 0 ? 10 : 0, right: 10),
                              child: FlatButton(onPressed: () {}, child: Text(products[index]), color: Colors.grey[300])));
                    },
                    physics: BouncingScrollPhysics(),
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal)),
          ),
          Expanded(
              child: FutureBuilder(
                  future: Future.wait([ApiService.getProductsById(widget.list[subCatIndex].subCategories[subCatIndex1].id.toString())]),
                  builder: (context, AsyncSnapshot snapshot) {
                    print("Snapshot Data" + snapshot.toString());
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null && snapshot.data[0].data.length > 0) {
                        ProductsById data = snapshot.data[0];
                        return ListView.separated(
                            separatorBuilder: (_, index) => Divider(color: Colors.grey, indent: 20, endIndent: 20),
                            itemBuilder: (_, index) => card(data.data[index]),
                            itemCount: data.data.length > 0 ? data.data.length : 0);
                      } else {
                        return Center(child: Text("Product not found!", style: TextStyle(color: Colors.black)));
                      }
                    } else
                      return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
                  }))
        ])));
  }

  Widget card(Products item) {
    return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetail(item))),
        child: Container(
            padding: EdgeInsets.all(20),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.network(URLS.PAL_IMAGE_URL + "/pub/media/catalog/product" + item.images[0].file,
                  width: 100, height: 100, fit: BoxFit.contain),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(item.name,
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        SizedBox(height: 7),
                        RichText(
                            text: TextSpan(
                                text: "\u20b9${(item.attributes.specialPrice * item.quantity)}\t",
                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: "\u20b9${item.price * item.quantity}",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "\t\tYou Save \u20b9${(item.price - double.parse(item.attributes.specialPrice)) * item.quantity}",
                                  style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold))
                            ])),
                        SizedBox(height: 10),
                        item.inCart
                            ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: FlatButton(
                                        child: Icon(Icons.remove, color: Colors.white),
                                        onPressed: () {
                                          if (item.quantity != 1) {
                                            setState(() => item.quantity--);
                                          } else {
                                            setState(() => item.inCart = false);
                                          }
                                        },
                                        color: Myapp.primaryColor,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),
                                SizedBox(width: 10),
                                Text(item.quantity.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                SizedBox(width: 10),
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: FlatButton(
                                        child: Icon(Icons.add, color: Colors.white),
                                        onPressed: item.quantity <= item.maxQuantity
                                            ? () {
                                                if (item.quantity != item.maxQuantity) {
                                                  setState(() => item.quantity++);
                                                }
                                              }
                                            : null,
                                        color: item.quantity >= item.maxQuantity ? Myapp.primaryColor.withOpacity(0.7) : Myapp.primaryColor,
                                        disabledColor: Myapp.primaryColor.withOpacity(0.7),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))))
                              ])
                            : Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                    height: 32,
                                    width: 95,
                                    child: FlatButton(
                                        child: Text("ADD", style: TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          setState(() => item.inCart = true);
                                          scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Added to cart successfully")));
                                        },
                                        color: Myapp.primaryColor)))
                      ])))
            ])));
  }
}

