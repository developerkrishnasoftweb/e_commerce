// ignore: must_be_immutable
import 'package:e_commerce/UI/cart.dart';
import 'package:e_commerce/UI/product_description.dart';
import 'package:e_commerce/UI/sort_by.dart';
import 'package:flutter/material.dart';

import 'filter_list.dart';

class Products extends StatefulWidget {
  final String title;
  final String id;

  Products({this.title, this.id});

  @override
  _ProductsState createState() => _ProductsState();
}

List _list = [Colors.amberAccent, Colors.indigoAccent, Colors.pinkAccent];

class _ProductsState extends State<Products> with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading:
                appBarIconButton(imagePath: "assets/icons/left-arrow.png", onPressed: () => Navigator.pop(context)),
            title: Text(
              widget.title ?? "Category",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
            ),
            centerTitle: false,
            backgroundColor: Colors.white,
            actions: [
              appBarIconButton(imagePath: "assets/icons/loupe.png", onPressed: () {}),
              appBarIconButton(imagePath: "assets/icons/heart.png", onPressed: () {}),
              appBarIconButton(
                  imagePath: "assets/icons/shopping-cart.png",
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Cart()))),
            ]),
        backgroundColor: Colors.grey[100],
        body: Column(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
          Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 10, childAspectRatio: 0.80, mainAxisSpacing: 10),
                  itemCount: 10,
                  padding: EdgeInsets.only(top: 20, bottom: 60),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index1) {
                    return GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ProductDescription(heroTag: "assets/logo.jpeg"))),
                        child: Column(children: [
                          Image(
                              image:
                                  // widget.childrenData[index].childrenData[index1].image.isEmpty ?
                                  AssetImage("assets/logo.jpeg")
                              //  : NetworkImage(URLS.IMAGE_URL + widget.childrenData[index].childrenData[index1].image)
                              ,
                              fit: BoxFit.fitWidth,
                              height: size.height * 0.21,
                              width: size.width * 0.41),
                          SizedBox(height: 5),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text("Product Name",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text("\$120.0",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff4E72D4))))),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text("Size: S, M, XL",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey)))),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                          height: 30,
                                          width: double.maxFinite,
                                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                                            Text("Colors: ",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey)),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: _list.length,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (BuildContext context, int i) {
                                                  return Padding(
                                                      padding: EdgeInsets.only(right: 3),
                                                      child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle, color: _list[i])));
                                                })
                                          ])))))
                        ]));
                  })),
          Container(
              height: 80,
              width: size.width,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(children: [
                Expanded(
                    child: FlatButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SortBy())),
                        icon: ImageIcon(AssetImage("assets/icons/sort.png")),
                        label: Text("SORT", style: TextStyle(color: Colors.black)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.black)),
                        padding: EdgeInsets.symmetric(vertical: 16))),
                SizedBox(width: 10),
                Expanded(
                    child: FlatButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FilterList())),
                        icon: ImageIcon(AssetImage("assets/icons/education.png")),
                        label: Text("FILTER", style: TextStyle(color: Colors.black)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.black)),
                        padding: EdgeInsets.symmetric(vertical: 16)))
              ]))
        ]));
  }
}

IconButton appBarIconButton({@required String imagePath, @required VoidCallback onPressed, Color color}) {
  return IconButton(
      onPressed: onPressed, splashRadius: 25, icon: ImageIcon(AssetImage(imagePath), color: color ?? Colors.black));
}
