import 'package:e_commerce/UI/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> category = ["All", "Classique", "Wedding"];
  List<String> tabs = ["Women", "Kids", "Mens", "Living"];
  List<Map<String, String>> img = [
    {"image": "assets/images/demo11.jpg", "name": "ad"},
    {"image": "assets/images/demo22.jpg", "name": "ad"},
    {"image": "assets/images/demo33.jpeg", "name": "ad"},
    {"image": "assets/images/demo44.jpg", "name": "ad"},
    {"image": "assets/images/demo11.jpg", "name": "ad"},
    {"image": "assets/images/demo22.jpg", "name": "ad"},
    {"image": "assets/images/demo33.jpeg", "name": "ad"},
    {"image": "assets/images/demo44.jpg", "name": "ad"},
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Shopping",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: ImageIcon(
                AssetImage("assets/icons/menu.png"),
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                icon: ImageIcon(
                  AssetImage("assets/icons/loupe.png"),
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: ImageIcon(
                  AssetImage("assets/icons/heart.png"),
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: ImageIcon(
                  AssetImage("assets/icons/shopping-cart.png"),
                  color: Colors.black,
                ),
              ),
            ],
            bottom: TabBar(
                tabs: tabs.map((e) {
              return Tab(
                child: Text(
                  e,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              );
            }).toList()),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: size.height * 0.4,
                    width: size.width,
                    child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, childAspectRatio: 1,crossAxisSpacing: 8,mainAxisSpacing: 8),
                      itemCount: img.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Category(title: img[index]["name"],)));
                          },
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(img[index]['image']),
                                fit: BoxFit.fill
                              )
                            ),
                            child : Text(img[index]["name"],style: TextStyle(color: Colors.white),),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 150.0,
                        width: size.width*0.4,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black),
                            image: DecorationImage(
                              image: new AssetImage("assets/images/offer1.jpg"),
                              fit: BoxFit.fill,
                            )
                        ),
                      ),
                      Container(
                        height: 150.0,
                        width: size.width*0.4,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black),
                            image: DecorationImage(
                              image: new AssetImage("assets/images/offer2.png"),
                              fit: BoxFit.fill,
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 150.0,
                        width: size.width*0.4,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black),
                            image: DecorationImage(
                              image: new AssetImage("assets/images/offer3.jpg"),
                              fit: BoxFit.fill,
                            )
                        ),
                      ),
                      Container(
                        height: 150.0,
                        width: size.width*0.4,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black),
                          image: DecorationImage(
                            image: new AssetImage("assets/images/offer4.jpg"),
                            fit: BoxFit.fill,
                          )
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
