import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';

class SubcategoryDetails extends StatefulWidget {
  @override
  _SubcategoryDetailsState createState() => _SubcategoryDetailsState();
}

class _SubcategoryDetailsState extends State<SubcategoryDetails> {
  List<Category> categories = [
    Category(
        title: "Atta, Flours & Sooji",
        image: "https://www.jiomart.com/images/category/14/thumb/0-14.png"),
    Category(
        title: "Dals & Pulses",
        image:
            "https://www.jiomart.com/images/category/17/thumb/dals-pulses-20200714.png"),
    Category(
        title: "Rice & Rice Products",
        image:
            "https://www.jiomart.com/images/category/14/thumb/rice-rice-products-20200722.png"),
    Category(
        title: "Edible Oil",
        image: "https://www.jiomart.com/images/category/18/thumb/0-18.png"),
    Category(
        title: "Masalas Spices",
        image: "https://www.jiomart.com/images/category/15/thumb/0-15.png"),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {})
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.grey[200],
              width: size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                        text: "Deliver to\t\t",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: "394221",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))
                        ]),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 76,
            width: size.width,
            color: Colors.grey[100],
            child: Row(
              children: [
                Container(
                  width: 110,
                  height: 76,
                  color: Colors.white,
                  child: FlatButton(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Staples"),
                          Icon(Icons.arrow_drop_down_outlined)
                        ]),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return BottomSheet(
                              onClosing: () {},
                              builder: (_) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        "Category",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        splashRadius: 25,
                                      ),
                                    ),
                                    Expanded(
                                        child: ListView.separated(
                                          separatorBuilder: (_, index) {
                                            return Divider(
                                              color: Colors.grey,
                                            );
                                          },
                                          itemBuilder: (_, index) {
                                            return ListTile(
                                              leading: Image.network(
                                                "https://www.jiomart.com/images/category/141/thumb/fruits-vegetables-20200520.png",
                                                width: 40,
                                                height: 40,
                                              ),
                                              title: Text(
                                                "Fruits & Vegetables",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                "Fresh Fruits,Fresh Vegetables,Herbs & Season ,Exotic Fruits & Vegetables",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              onTap: () {},
                                            );
                                          },
                                          itemCount: 10,
                                        ))
                                  ],
                                );
                              },
                              backgroundColor: Colors.white,
                              enableDrag: true,
                            );
                          });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return GestureDetector(
                          onTap: () {
                            categories.forEach((element) {
                              setState(() {
                                element.isSelected = false;
                              });
                            });
                            setState(() {
                              categories[index].isSelected = true;
                            });
                          },
                          child: Container(
                            margin:
                            EdgeInsets.only(left: 10, bottom: 7, top: 7),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            width: 130,
                            height: 76,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                border: Border.all(
                                    color: categories[index].isSelected
                                        ? Myapp.primaryColor
                                        : Colors.white,
                                    width: 2)),
                            child: Row(
                              children: [
                                Image.network(
                                  categories[index].image,
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Text(
                                      categories[index].title,
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: categories[index].isSelected
                                              ? Myapp.primaryColor
                                              : Colors.black),
                                    ))
                              ],
                            ),
                          ));
                    },
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    physics: BouncingScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey[300],
            width: size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("34 products"),
                FlatButton.icon(
                  onPressed: () {},
                  label: Text("Sort | Filter"),
                  icon: Icon(Icons.filter_alt_rounded),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListView.separated(
              separatorBuilder: (_, index) {
                return SizedBox(width: 10);
              },
              itemBuilder: (_, index) {
                return FlatButton(onPressed: () {}, child: Text("Carrot"), color: Colors.grey[300],);
              },
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Expanded(child: ListView.builder(itemBuilder: (_, index) {
            return Container();
          }, itemCount: 10,))
        ],
      ),
    );
  }
}

class Category {
  final String title, image;
  bool isSelected;

  Category({this.title, this.image, this.isSelected: false});
}
