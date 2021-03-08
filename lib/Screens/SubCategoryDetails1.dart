import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/ProductsById.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ProductDetail.dart';

class SubcategoryDetails1 extends StatefulWidget {
  List<MainData> list;
  int id;

  SubcategoryDetails1({this.list, this.id});

  @override
  _SubcategoryDetailsState createState() => _SubcategoryDetailsState();
}

class _SubcategoryDetailsState extends State<SubcategoryDetails1> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> filterTabs = ["Popularity", "High to Low", "Low to High", "Discount"];

  var subCatIndex = 0;
  var subCatIndex1 = 0;
  var subCatIndex2 = 0;
  var productId = 0;

  List<MainData> list = [];
  List<Products> productsList = [];
  List<ChildSubCategory> childSubCategoryList = [];
  List<SubCategotyLIst> subCategories = [];
  ProductsById products;
  bool productsFound = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subCatIndex = widget.id ?? 1;
    subCatIndex1 = 0;
    subCatIndex2 = 0;

    list = widget.list;

    if (list.length > subCatIndex) {
      subCategories = list[subCatIndex].subCategories;
      if (list[subCatIndex].subCategories.length > subCatIndex1) {
        list[subCatIndex].subCategories[subCatIndex1].isSelected = true;
        childSubCategoryList = list[subCatIndex].subCategories[subCatIndex1].childSubCategory;
        if (list[subCatIndex].subCategories[subCatIndex1].childSubCategory.length > subCatIndex2) {
          list[subCatIndex].subCategories[subCatIndex1].childSubCategory[subCatIndex2].isSelected = true;
          productId = list[subCatIndex].subCategories[subCatIndex1].childSubCategory[subCatIndex2].id != 0
              ? list[subCatIndex].subCategories[subCatIndex1].childSubCategory[subCatIndex2].id
              : list[subCatIndex].subCategories[subCatIndex1].id;

        } else {
          productId = 0;
        }
      } else {
        childSubCategoryList = [];
        productId = 0;
      }
    } else {
      childSubCategoryList = [];
      productsList = [];
      subCategories = [];
      productId = 0;
    }
    getProducts();


  }

  getProducts() async {
    setState(() {
      products = null;
      productsFound = false;
    });
    ProductsById productsById = await ApiService.getProductsById(productId.toString());

  //  print("productsById"+productsById.data.toString() +"___"+ productId.toString());

    if(productsById == null) {
      setState(() {
        productsFound = true;
      });
      return;
    }
    if (productsById.status) {
      setState(() {
        products = productsById;
      });
    } else {
      setState(() {
        productsFound = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    list = widget.list;

    if (list.length > subCatIndex) {
      subCategories = list[subCatIndex].subCategories;
      if (list[subCatIndex].subCategories.length > subCatIndex1) {
        list[subCatIndex].subCategories[subCatIndex1].isSelected = true;
        childSubCategoryList = list[subCatIndex].subCategories[subCatIndex1].childSubCategory;
        if (list[subCatIndex].subCategories[subCatIndex1].childSubCategory.length > subCatIndex2) {
          list[subCatIndex].subCategories[subCatIndex1].childSubCategory[subCatIndex2].isSelected = true;
          productId = list[subCatIndex].subCategories[subCatIndex1].childSubCategory[subCatIndex2].id != 0
              ? list[subCatIndex].subCategories[subCatIndex1].childSubCategory[subCatIndex2].id
              : list[subCatIndex].subCategories[subCatIndex1].id;
        } else {
          productId = 0;
        }
      } else {
        childSubCategoryList = [];
        productId = 0;
      }
    } else {
      childSubCategoryList = [];
      productsList = [];
      subCategories = [];
      productId = 0;
    }

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 50.sp,
          title: Text("Product", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})],
        ),
        body: Container(
            child: Column(children: [
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
                              child: Text(list != null ? list[subCatIndex].name : "Staples",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold))),
                          Icon(Icons.arrow_drop_down_outlined)
                        ]),
                        onPressed: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => BottomSheet(
                                onClosing: () {},
                                builder: (_) => Column(children: [
                                      SizedBox(height: 50.sp),
                                      ListTile(
                                          title: Text("Category", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                                          trailing: IconButton(
                                              icon: Icon(Icons.close), onPressed: () => Navigator.pop(context), splashRadius: 25)),
                                      Expanded(
                                          child: ListView.separated(
                                              separatorBuilder: (_, index) => Divider(color: Colors.grey),
                                              itemBuilder: (_, index) => ListTile(
                                                  leading: Image.network(
                                                      list != null
                                                          ? URLS.PAL_IMAGE_URL + list[index].image
                                                          : "https://www.jiomart.com/images/category/141/thumb/fruits-vegetables-20200520.png",
                                                      width: 40.sp,
                                                      height: 40.sp),
                                                  title: Text(list != null ? list[index].name : "Fruits & Vegetables",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
                                                  // subtitle: Text(
                                                  //   "Fresh Fruits,Fresh Vegetables,Herbs & Season ,Exotic Fruits & Vegetables",
                                                  //   maxLines: 1,
                                                  //   overflow: TextOverflow.ellipsis,
                                                  // ),
                                                  onTap: () => setState(() {
                                                        subCatIndex = index;
                                                        subCatIndex1 = 0;
                                                        subCatIndex2 = 0;
                                                        Navigator.of(context).pop();
                                                        getProducts();
                                                      })),
                                              itemCount: list != null ? list.length : 10))
                                    ]),
                                backgroundColor: Colors.white,
                                enableDrag: true)),
                        color: Colors.grey[100])),
                Expanded(
                    child: ListView.builder(
                        itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              subCategories.forEach((element) => setState(() => element.isSelected = false));
                              setState(() {
                                subCatIndex1 = index;
                                subCategories[index].isSelected = true;
                              });
                              getProducts();
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: index == 0 ? 10 : 0, bottom: 7, top: 7, right: 10),
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                width: 120.sp,
                                height: 60.sp,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                    border:
                                        Border.all(color: subCategories[index].isSelected ? Myapp.primaryColor : Colors.white, width: 2)),
                                child: Row(children: [
                                  Image.network(URLS.PAL_IMAGE_URL + subCategories[index].image, height: 30.sp, width: 30.sp),
                                  SizedBox(width: 10.sp),
                                  Expanded(
                                      child: Text(subCategories[index].name,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                              color: subCategories[index].isSelected ? Myapp.primaryColor : Colors.black)))
                                ]))),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: subCategories.length,
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
                      return showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return FutureBuilder(
                                future: Future.wait([ApiService.getFiltersData(list != null ? list[subCatIndex].id.toString() : "")]),
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
                                                        shrinkWrap: true,
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
                                                              child: Text("Clear All",
                                                                  style: TextStyle(color: Myapp.primaryColor)),
                                                              color: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(7),
                                                                  side: BorderSide(color: Myapp.primaryColor))))),
                                                  Expanded(
                                                    child: Container(
                                                        margin: EdgeInsets.only(left: 10, right: 5),
                                                        child: FlatButton(
                                                            onPressed: () {

                                                            },
                                                            child:
                                                            Text("Apply Filter", style: TextStyle(color: Colors.white)),
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
          Container(
              height: 50,
              width: size.width,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListView.builder(
                  itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(left: index == 0 ? 10 : 0, right: 10),
                      child: FlatButton(
                          onPressed: () {
                            childSubCategoryList.forEach((element) => setState(() => element.isSelected = false));
                            setState(() {
                              subCatIndex2 = index;
                              childSubCategoryList[index].isSelected = true;
                            });
                            getProducts();
                          },
                          child: Text(childSubCategoryList[index].name,
                              style: TextStyle(color: childSubCategoryList[index].isSelected ? Colors.white : Colors.black)),
                          color: childSubCategoryList[index].isSelected ? Myapp.primaryColor : Colors.grey[300])),
                  physics: BouncingScrollPhysics(),
                  itemCount: list[subCatIndex].subCategories.length > 0 ? childSubCategoryList.length : 0,
                  scrollDirection: Axis.horizontal)),
              Expanded(
                child: !productsFound
                    ? products != null
                    ? ListView.separated(
                    separatorBuilder: (_, index) => Divider(
                        color: Colors.grey, indent: 20, endIndent: 20),
                    itemBuilder: (_, index) => card(products.data[index]),
                    itemCount:
                    products.data.length > 0 ? products.data.length : 0)
                    : Container(
                    child: Center(child: CircularProgressIndicator()))
                    : Container(child: Center(child: Text("Product not found"))),
              )
        ])));
  }
  Widget card(Products item) {
    return GestureDetector(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => ProductDetail(item))),
        child: Container(
            padding: EdgeInsets.all(20),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.network(
                  URLS.PAL_IMAGE_URL +
                      "/pub/media/catalog/product" +
                      item.images[0].file,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(height: 7),
                            RichText(
                                text: TextSpan(
                                    text:
                                    "\u20b9${item.price * item.quantity}\t",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text:
                                          "\u20b9${item.attributes.specialPrice}",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14,
                                              decoration:
                                              TextDecoration.lineThrough,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                          "\t\tYou Save \u20b9${double.parse(item.attributes.specialPrice) * item.quantity}",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold))
                                    ])),
                            SizedBox(height: 10),
                            item.inCart
                                ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: FlatButton(
                                          child: Icon(Icons.remove,
                                              color: Colors.white),
                                          onPressed: () =>
                                              _removeItemQuantity(item),
                                          color: Myapp.primaryColor,
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50)))),
                                  SizedBox(width: 10),
                                  Text(item.quantity.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  SizedBox(width: 10),
                                  SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: FlatButton(
                                          child: Icon(Icons.add,
                                              color: Colors.white),
                                          onPressed: () => _addItemQuantity(item),
                                          color: item.quantity >=
                                              item.maxQuantity
                                              ? Myapp.primaryColor
                                              .withOpacity(0.7)
                                              : Myapp.primaryColor,
                                          disabledColor: Myapp
                                              .primaryColor
                                              .withOpacity(0.7),
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50))))
                                ])
                                : Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                    height: 32,
                                    width: 95,
                                    child: FlatButton(
                                        child: item.isLoading ? SizedBox(height: 25, width: 25, child: CircularProgressIndicator(strokeWidth: 2)) : Text("ADD",
                                            style: TextStyle(
                                                color: Colors.white)),
                                        onPressed: item.isLoading ? null : () => _addToCart(item),
                                        color: Myapp.primaryColor)))
                          ])))
            ])));
  }

  void _addToCart(Products item) async {
    setState(() {
      item.isLoading = true;
    });
    int quantity = await ApiService.getProductQuantity(item.id.toString());
    if(quantity != null) {
      if(quantity > 0) {
        setState(() {
          item.maxQuantity = quantity;
          item.isLoading = false;
        });
        setState(() => item.inCart = true);
        scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text("Added to cart successfully")));
      } else {
        setState(() {
          item.isLoading = false;
        });
        scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text("Sorry, Product is out of stock")));
      }
    } else {
      setState(() {
        item.isLoading = false;
      });
      scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("Something went wrong please try again later")));
    }
  }

  _removeItemQuantity(Products item) {
    if (item.quantity != 1) {
      setState(() => item.quantity--);
    } else {
      setState(() => item.inCart = false);
    }
  }

  _addItemQuantity(Products item) {
    if(item.quantity <=
        item.maxQuantity) {
      if (item.quantity !=
          item.maxQuantity) {
        setState(() =>
        item.quantity++);
      }
    }
  }
}
