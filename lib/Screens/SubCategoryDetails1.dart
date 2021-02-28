import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/MainCategory.dart';
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
  List<FilterList> filterList = [
    FilterList(
        title: "Availability",
        isMultipleSelection: true,
        filterItems: [
          FilterItems(title: "In Stock Products"),
          FilterItems(title: "Out of Stock Products"),
        ],
        isSelected: true),
    FilterList(
      title: "Categories",
      isMultipleSelection: false,
      filterItems: [
        FilterItems(title: "Exotic Vegetables"),
        FilterItems(title: "Citrus Fruits"),
        FilterItems(title: "Root vegetable"),
        FilterItems(title: "Beans"),
        FilterItems(title: "Gourd"),
        FilterItems(title: "Vegetable Others"),
        FilterItems(title: "Apples"),
        FilterItems(title: "Brinjal"),
        FilterItems(title: "Onion"),
        FilterItems(title: "Banana"),
        FilterItems(title: "Ginger"),
        FilterItems(title: "Grapes"),
        FilterItems(title: "Melons"),
        FilterItems(title: "Others"),
        FilterItems(title: "Berries"),
        FilterItems(title: "Cabbage"),
        FilterItems(title: "Capsicum"),
        FilterItems(title: "Carrot"),
        FilterItems(title: "Cauliflower"),
        FilterItems(title: "Corn"),
        FilterItems(title: "Cucumber"),
        FilterItems(title: "Drumstick"),
        FilterItems(title: "Exotic Fruits"),
      ],
    ),
    FilterList(
      title: "Brands",
      isMultipleSelection: true,
      filterItems: [
        FilterItems(title: "Loose"),
      ],
    ),
    FilterList(
      title: "Price",
      isMultipleSelection: false,
      filterItems: [
        FilterItems(title: "\u20b97 - \u20b9100"),
        FilterItems(title: "\u20b9100 - \u20b9200"),
        FilterItems(title: "\u20b9200 - \u20b9253"),
      ],
    ),
  ];
  List<Category> categories = [
    Category(title: "Atta, Flours & Sooji", image: "https://www.jiomart.com/images/category/14/thumb/0-14.png"),
    Category(title: "Dals & Pulses", image: "https://www.jiomart.com/images/category/17/thumb/dals-pulses-20200714.png"),
    Category(
        title: "Rice & Rice Products", image: "https://www.jiomart.com/images/category/14/thumb/rice-rice-products-20200722.png"),
    Category(title: "Edible Oil", image: "https://www.jiomart.com/images/category/18/thumb/0-18.png"),
    Category(title: "Masalas Spices", image: "https://www.jiomart.com/images/category/15/thumb/0-15.png"),
  ];
  List<String> products = ["ALL", "Exotic Vegetables", "Citrus Fruits", "Root Vegetable", "Beans", "Guard", "Vegetable Others"],
      filterTabs = ["Popularity", "High to Low", "Low to High", "Discount"];
  List<Item> items = [
    Item(
        image:
            "https://www.jiomart.com/images/product/75x75/590122516/fortune-health-physically-refined-rice-bran-oil-5-l-india-gate-feast-rozzana-basmati-rice-5-kg-combo-pack-0-20201229.jpg",
        category: "Groccery",
        price: 12,
        name: "Aashirvaad Multigrain Atta 5 kg",
        quantity: 1,
        discount: 10,
        maxQuantity: 5),
    Item(
        image:
            "https://www.jiomart.com/images/product/75x75/491504124/super-sarvottam-physicaly-refined-100-rice-bran-oil-1-l-pouch-0-20201021.jpg",
        category: "Groccery",
        price: 200,
        name: "Tata Lite Free Flow Iodised Salt 1 kg",
        quantity: 1,
        discount: 30,
        maxQuantity: 1),
    Item(
        image:
            "https://www.jiomart.com/images/product/75x75/491076026/oleev-active-ricebran-based-blended-oil-5-l-jar-0-20200825.jpg",
        category: "Groccery",
        price: 121.0,
        name: "Good Life Tur Dal 1 kg",
        quantity: 5,
        discount: 20,
        inCart: true,
        maxQuantity: 20),
    Item(
        image:
            "https://www.jiomart.com/images/product/75x75/491278308/priya-fortified-with-vitamin-a-d-refined-sunflower-oil-1-l-0-20210119.jpg",
        category: "Groccery",
        price: 123,
        name: "Good Life Almonds 500 g",
        quantity: 1,
        discount: 15,
        maxQuantity: 10),
    Item(
        image:
            "https://www.jiomart.com/images/product/75x75/491076025/oleev-active-ricebran-based-blended-oil-1-l-pouch-0-20200805.jpg",
        category: "Groccery",
        price: 200,
        name: "Tata Lite Free Flow Iodised Salt 1 kg",
        quantity: 1,
        discount: 30,
        maxQuantity: 1),
  ];

  var subCatIndex = 0;
  var subCatIndex1 = 0;
  var subCatIndex2 = 0;

  List<MainData> list = [];
  List<Products> productsList = [];
  List<ChildSubCategory> childSubCategoryList = [];
  List<SubCategotyLIst> subCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subCatIndex = widget.id ?? 1;
    subCatIndex1 = 0;
    subCatIndex2 = 0;
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
          productsList = list[subCatIndex].subCategories[subCatIndex1].childSubCategory[subCatIndex2].products;
        } else {
          productsList = [];
        }
      } else {
        childSubCategoryList = [];
        productsList = [];
      }
    } else {
      childSubCategoryList = [];
      productsList = [];
      subCategories = [];
    }

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 50.sp,
          title: Text("Product", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          actions: [IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})],
        ),
        body: Container(
          child: FutureBuilder(
              future: Future.wait([ApiService.getSubCategories(widget.id.toString() ?? "1605")]),
              builder: (context, AsyncSnapshot snapshot) {
                print("Snapshot Data" + snapshot.toString());
                if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                  return Column(children: [
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
                                        TextSpan(
                                            text: "394221",
                                            style: TextStyle(color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.bold))
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
                                      list != null ? list[subCatIndex].name : "Staples",
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
                                                      title: Text("Category",
                                                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                                                      trailing: IconButton(
                                                          icon: Icon(Icons.close),
                                                          onPressed: () => Navigator.pop(context),
                                                          splashRadius: 25)),
                                                  Expanded(
                                                      child: ListView.separated(
                                                          separatorBuilder: (_, index) => Divider(color: Colors.grey),
                                                          itemBuilder: (_, index) {
                                                            return ListTile(
                                                                leading: Image.network(
                                                                    list != null
                                                                        ? URLS.PAL_IMAGE_URL + list[index].image
                                                                        : "https://www.jiomart.com/images/category/141/thumb/fruits-vegetables-20200520.png",
                                                                    width: 40.sp,
                                                                    height: 40.sp),
                                                                title: Text(
                                                                    list != null ? list[index].name : "Fruits & Vegetables",
                                                                    style:
                                                                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
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
                                                                    }));
                                                          },
                                                          itemCount: list != null ? list.length : 10))
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
                                          subCategories.forEach((element) => setState(() => element.isSelected = false));
                                          setState(() {
                                            subCatIndex1 = index;
                                            subCategories[index].isSelected = true;
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
                                                    color: subCategories[index].isSelected ? Myapp.primaryColor : Colors.white,
                                                    width: 2)),
                                            child: Row(children: [
                                              Image.network(URLS.PAL_IMAGE_URL + subCategories[index].image,
                                                  height: 30.sp, width: 30.sp),
                                              SizedBox(width: 10.sp),
                                              Expanded(
                                                  child: Text(subCategories[index].name,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12.sp,
                                                          color: subCategories[index].isSelected
                                                              ? Myapp.primaryColor
                                                              : Colors.black)))
                                            ])));
                                  },
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
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${items.length} products"),
                              FlatButton.icon(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (_) {
                                          return StatefulBuilder(builder: (_, state) {
                                            return BottomSheet(
                                                onClosing: () {},
                                                builder: (_) {
                                                  return Column(children: [
                                                    SizedBox(height: MediaQuery.of(context).padding.top),
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
                                                        child: Row(children: [
                                                      Flexible(
                                                          flex: 1,
                                                          child: ListView.separated(
                                                              separatorBuilder: (_, index) =>
                                                                  Divider(height: 0.5, color: Colors.grey),
                                                              itemBuilder: (_, index) {
                                                                return GestureDetector(
                                                                    child: Container(
                                                                        height: 50,
                                                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                                                        alignment: Alignment.centerLeft,
                                                                        decoration: BoxDecoration(
                                                                            color: filterList[index].isSelected
                                                                                ? Colors.white
                                                                                : Colors.grey[200]),
                                                                        child: Text(filterList[index].title)),
                                                                    onTap: () {
                                                                      filterList.forEach(
                                                                          (element) => state(() => element.isSelected = false));
                                                                      state(() => filterList[index].isSelected = true);
                                                                    });
                                                              },
                                                              itemCount: filterList.length,
                                                              physics: BouncingScrollPhysics())),
                                                      Flexible(
                                                          flex: 2,
                                                          child: ListView.separated(
                                                              separatorBuilder: (_, index) =>
                                                                  Divider(height: 0.5, color: Colors.grey),
                                                              itemBuilder: (_, index) {
                                                                FilterList filter =
                                                                    filterList.where((element) => element.isSelected).first;
                                                                return filter.isMultipleSelection
                                                                    ? CheckboxListTile(
                                                                        value: filter.filterItems[index].isSelected,
                                                                        onChanged: (value) {
                                                                          state(() => filter.filterItems[index].isSelected =
                                                                              !filter.filterItems[index].isSelected);
                                                                        },
                                                                        title: Text(filter.filterItems[index].title),
                                                                      )
                                                                    : RadioListTile<FilterItems>(
                                                                        value: filter.filterItems[index],
                                                                        groupValue: filter.filterItem,
                                                                        title: Text(filter.filterItems[index].title),
                                                                        onChanged: (value) =>
                                                                            state(() => filter.filterItem = value),
                                                                        controlAffinity: ListTileControlAffinity.trailing);
                                                              },
                                                              itemCount: filterList
                                                                  .where((element) => element.isSelected)
                                                                  .first
                                                                  .filterItems
                                                                  .length,
                                                              physics: BouncingScrollPhysics()))
                                                    ]))
                                                  ]);
                                                },
                                                backgroundColor: Colors.white,
                                                enableDrag: true);
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
                            itemBuilder: (_, index) {
                              return Container(
                                  margin: EdgeInsets.only(left: index == 0 ? 10 : 0, right: 10),
                                  child: FlatButton(
                                      onPressed: () {
                                        childSubCategoryList.forEach((element) => setState(() => element.isSelected = false));
                                        setState(() {
                                          subCatIndex2 = index;
                                          childSubCategoryList[index].isSelected = true;
                                        });
                                      },
                                      child: Text(childSubCategoryList[index].name,
                                          style: TextStyle(
                                              color: childSubCategoryList[index].isSelected ? Colors.white : Colors.black)),
                                      color: childSubCategoryList[index].isSelected ? Myapp.primaryColor : Colors.grey[300]));
                            },
                            physics: BouncingScrollPhysics(),
                            itemCount: list[subCatIndex].subCategories.length > 0 ? childSubCategoryList.length : 0,
                            scrollDirection: Axis.horizontal)),
                    Expanded(
                        child: ListView.separated(
                            separatorBuilder: (_, index) => Divider(color: Colors.grey, indent: 20, endIndent: 20),
                            itemBuilder: (_, index) => card(productsList[index]),
                            itemCount: productsList.length > 0 ? productsList.length : 0))
                  ]);
                } else
                  return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
              }),
        ));
  }

  Widget card(Products item) {
    print("Item Details" + item.name);
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
                                text: "\u20b9${(item.price * item.quantity) - (item.quantity * item.discount)}\t",
                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: "\u20b9${double.parse(item.attributes.specialPrice) * item.quantity}",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "\t\tYou Save \u20b9${double.parse(item.attributes.specialPrice) * item.quantity}",
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
                                        color: item.quantity >= item.maxQuantity
                                            ? Myapp.primaryColor.withOpacity(0.7)
                                            : Myapp.primaryColor,
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
                                          scaffoldKey.currentState
                                              .showSnackBar(SnackBar(content: Text("Added to cart successfully")));
                                        },
                                        color: Myapp.primaryColor)))
                      ])))
            ])));
  }
}

class Category {
  final String title, image;
  bool isSelected;

  Category({this.title, this.image, this.isSelected: false});
}

class Item {
  final String image, name, category;
  final double price, maxQuantity, discount;
  int quantity;
  bool inCart;

  Item({this.image, this.name, this.category, this.price, this.maxQuantity, this.discount, this.inCart: false, this.quantity});
}

class FilterList {
  final String title;
  final bool isMultipleSelection;
  bool isSelected;
  final List<FilterItems> filterItems;
  FilterItems filterItem;

  FilterList({this.title, this.isMultipleSelection: false, this.filterItems, this.isSelected: false});
}

class FilterItems {
  bool isSelected;
  final String title;

  FilterItems({this.title, this.isSelected: false});
}