import 'package:e_commerce/Models/Categories.dart';
import 'package:e_commerce/UI/category.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: ApiService.getHomeCategories(),
        builder: (context, snapshot) {
          final Categories data = snapshot.data;
          print("data" + data.toString());
          if (snapshot.connectionState == ConnectionState.done && data != null) {
            return DefaultTabController(
                length: data.childrenData.length,
                child: Scaffold(
                    appBar: AppBar(
                        title: Text("Shopping", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        backgroundColor: Colors.white,
                        leading: IconButton(icon: ImageIcon(AssetImage("assets/icons/menu.png"), color: Colors.black)),
                        actions: [
                          IconButton(icon: ImageIcon(AssetImage("assets/icons/loupe.png"), color: Colors.black)),
                          IconButton(icon: ImageIcon(AssetImage("assets/icons/heart.png"), color: Colors.black)),
                          IconButton(icon: ImageIcon(AssetImage("assets/icons/shopping-cart.png"), color: Colors.black))
                        ],
                        bottom: TabBar(
                            isScrollable: true,
                            tabs: data.childrenData.map((e) {
                              return Tab(
                                  child:
                                      Text(e.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
                            }).toList())),
                    body: TabBarView(
                        children: List<Widget>.generate(data.childrenData.length, (int index) {
                      return _pageData(size, data.childrenData[index].childrenData);
                    }))));
          } else
            return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
        });
  }

  _pageData(Size size, List<ChildrenData> childrenData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              width: size.width,
              child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 0.7, crossAxisSpacing: 8, mainAxisSpacing: 8),
                  itemCount: childrenData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Category(
                                      childrenData: childrenData[index].childrenData,
                                      title: childrenData[index].name)));
                        },
                        child: Column(children: [
                          AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Container(
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: childrenData[index].image.isEmpty
                                              ? AssetImage("assets/logo.jpeg")
                                              : NetworkImage(URLS.IMAGE_URL + childrenData[index].image),
                                          fit: BoxFit.cover)))),
                          Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(childrenData[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                                  textAlign: TextAlign.center))
                        ]));
                  })),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
                height: 150.0,
                width: size.width * 0.4,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                    image: DecorationImage(image: new AssetImage("assets/images/offer1.jpg"), fit: BoxFit.fill))),
            Container(
                height: 150.0,
                width: size.width * 0.4,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                    image: DecorationImage(image: new AssetImage("assets/images/offer2.png"), fit: BoxFit.fill)))
          ]),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
                height: 150.0,
                width: size.width * 0.4,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                    image: DecorationImage(image: new AssetImage("assets/images/offer3.jpg"), fit: BoxFit.fill))),
            Container(
                height: 150.0,
                width: size.width * 0.4,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                    image: DecorationImage(image: new AssetImage("assets/images/offer4.jpg"), fit: BoxFit.fill)))
          ]),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
