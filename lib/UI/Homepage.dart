import 'package:e_commerce/Models/Departments.dart';
import 'package:e_commerce/UI/category.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Screens/NavigationDrawer.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return FutureBuilder(
        future: ApiService.getDepartments(),
        builder: (context, snapshot) {
          final Departments data = snapshot.data;
          print("data" + data.toString());
          if (snapshot.connectionState == ConnectionState.done && data != null) {
            return DefaultTabController(
                length: data.data.length,
                child: Scaffold(
                    key: _scaffoldKey,
                    appBar: AppBar(
                        title: Text("Shopping", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        backgroundColor: Colors.white,
                        leading: IconButton(
                            icon: ImageIcon(AssetImage("assets/icons/menu.png"), color: Colors.black),
                            onPressed: () => _scaffoldKey.currentState.openDrawer()),
                        actions: [
                          IconButton(icon: ImageIcon(AssetImage("assets/icons/loupe.png"), color: Colors.black)),
                          IconButton(icon: ImageIcon(AssetImage("assets/icons/heart.png"), color: Colors.black)),
                          IconButton(icon: ImageIcon(AssetImage("assets/icons/shopping-cart.png"), color: Colors.black))
                        ],
                        bottom: TabBar(
                            isScrollable: true,
                            indicatorColor: Color(0xff4E72D4),
                            tabs: data.data
                                .map((e) => Tab(
                                    child: Text(e.title,
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))))
                                .toList())),
                    drawer: navigationDrawer(),
                    body: TabBarView(
                        children: List<Widget>.generate(data.data.length, (int index) {
                      return _pageData(size, data.data[index].categories);
                    }))));
          } else
            return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
        });
  }

  _pageData(Size size, List<Categories> categories) {
    return SingleChildScrollView(
        child: Column(children:[
      Container(
          width: size.width,
          child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: (size.width * 0.4 / 250.h),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Category(
                                categoryId: categories[index].id.toString(),
                                departmentId: categories[index].departmentId.toString()))),
                    child: Column(children: [
                      AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: categories[index].image.isEmpty
                                          ? AssetImage("assets/logo.jpeg")
                                          : NetworkImage(URLS.IMAGE_URL + categories[index].image),
                                      fit: BoxFit.cover)))),
                      Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(categories[index].title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(color: Colors.black, fontSize: 15.sp),
                              textAlign: TextAlign.center))
                    ]));
              })),
      SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
            height: 150.0,
            width: size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
                image: DecorationImage(image: AssetImage("assets/images/offer1.jpg"), fit: BoxFit.fill))),
        Container(
            height: 150.0,
            width: size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
                image: DecorationImage(image: AssetImage("assets/images/offer2.png"), fit: BoxFit.fill)))
      ]),
      SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
            height: 150.0,
            width: size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
                image: DecorationImage(image: AssetImage("assets/images/offer3.jpg"), fit: BoxFit.fill))),
        Container(
            height: 150.0,
            width: size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
                image: DecorationImage(image: AssetImage("assets/images/offer4.jpg"), fit: BoxFit.fill)))
      ]),
      SizedBox(height: 20)
    ]));
  }
}

