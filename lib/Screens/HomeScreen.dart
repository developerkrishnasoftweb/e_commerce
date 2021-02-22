import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/CartScreen.dart';
import 'package:e_commerce/Screens/SubCategoryDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import 'NavigationDrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final List<String> imgList = [
  'https://image.shutterstock.com/image-vector/weekend-sale-special-offer-banner-260nw-794599204.jpg',
  'https://images.indianexpress.com/2020/10/Untitled-design-2020-10-15T171350.830.jpg',
  'http://hotelakshaya.in/blog/wp-content/uploads/2018/03/special-offers-Hotel-Deals.jpg',
  'https://images.moneycontrol.com/static-mcnews/2020/09/MC-SUPERPRO-offer-770x433.jpg'
];

final List<String> grocerySlider = [
  'https://cdn.static-zoutons.com/images/originals/coupon-category/Grocery_Deals_1588267949.jpg',
  'https://i.ytimg.com/vi/nf06gJ4hg60/maxresdefault.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img17/Pantry/ITC/New/750x375.jpg',
  'https://hotdealszone.com/wp-content/uploads/2019/02/Flipkart-Grocery-Offers.png'
];

// ignore: non_constant_identifier_names
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pal", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          elevation: 0,
          actions: [
            IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                })
          ],
        ),
        // leading: IconButton(icon: ImageIcon(AssetImage("assets/icons/left-arrow.png"), color: Colors.white))),
        drawer: navigationDrawer(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          searchBarView(),
          FutureBuilder(
              future: Future.wait([ApiService.getHomeCategories()]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                  final AllCategories data = snapshot.data[0];
                  return Expanded(
                      child: SingleChildScrollView(
                          child: Column(children: [
                    categoriesListHorizontal(data.childrenData),
                    freeHomeDeliverySlider(imgList),
                    topCategories(),
                    topDeals(),
                    shopGroceries(),
                    offerListWithCategories(),
                    collectionWithBestOffers(),
                    kidsFashion()
                  ])));
                } else
                  return Expanded(
                      child: Container(color: Colors.white, child: Center(child: CircularProgressIndicator())));
              })
        ]));
  }

  Widget categoriesListHorizontal([List<ChildrenData> childrenData]) {

    return Padding(
      padding: EdgeInsets.only(top: 10.sp),
      child: Container(
          height: 100.h,
          child: ListView.builder(
              itemCount: childrenData.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              primary: false,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SubcategoryDetails( list :childrenData[index].childrenData))),
                  child: Container(
                      width: 70.h,
                      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 25.h,
                                backgroundImage: NetworkImage(URLS.IMAGE_URL + childrenData[index].image),
                                backgroundColor: Colors.transparent),
                            Center(
                                child: Text(childrenData[index].name,
                                    maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center))
                          ])),
                );
              })),
    );
  }

  Widget searchBarView() {
    return Container(
        color: Myapp.primaryColor,
        child: Padding(
            padding: EdgeInsets.fromLTRB(10.ssp, 0, 10.ssp, 10.ssp),
            child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    isDense: true,
                    // Added this
                    contentPadding: EdgeInsets.all(10.sp),
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5.ssp)),
                    hintText: "Search for Products and Brand"))));
  }

  freeHomeDeliverySlider(List<String> imgList) {
    return CarouselSlider(
        options: CarouselOptions(autoPlay: true, aspectRatio: 2.0, enlargeCenterPage: true),
        items: imageSlideView(imgList));
  }

  imageSlideView(List<String> imgList) {
    return imgList
        .map((item) => Container(
            child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                        children: <Widget>[Image.network(item, fit: BoxFit.cover, width: 800.sp, height: 500.sp)])))))
        .toList();
  }

  topCategories() {
    List<String> litems = [
      "ATTA, Flours & Sooji",
      "Edible Oils",
      "Biscuits",
      "Hair Care",
      "Soaps",
      "Kid's Wear",
      "Men's Wear",
      "Women's Wear"
    ];

    List<String> images = [
      "https://www.abeautifulplate.com/wp-content/uploads/2017/03/bread-flour-differnet-types-of-flour.jpg",
      "https://2.imimg.com/data2/OW/NJ/MY-3998144/2006020900280402-500x500.jpg",
      "https://bsmedia.business-standard.com/_media/bs/img/article/2018-02/18/full/1518965938-4605.jpg",
      "https://i.pinimg.com/736x/3e/71/86/3e7186bd207e26279a8d17d320532238.jpg",
      "https://dropbasket.in/wp-content/uploads/2020/10/lux.jpg",
      "https://i1.wp.com/www.wholesalecatalog.in/wp-content/uploads/formidable/6/291.jpg?w=936&h=1405&ssl=1",
      "https://st.depositphotos.com/1007995/1274/i/950/depositphotos_12746726-stock-photo-fashion-man-wearing-sunglasses-thinking.jpg",
      "https://ae01.alicdn.com/kf/HTB17NWQh5FTMKJjSZFAq6AkJpXa1/Winter-Big-Pendulum-Purple-Velvet-Dresses-Woman-Dress-2020-Lotus-Leaf-Long-Sleeve-Ladies-Dresses-Kleider.jpg_q50.jpg"
    ];

    return Container(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Column(children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Shop from Top Categories",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 0.85, crossAxisSpacing: 10.sp, mainAxisSpacing: 10.sp),
                      itemCount: litems.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () =>
                                Navigator.push(context, MaterialPageRoute(builder: (_) => SubcategoryDetails())),
                            child: Container(
                                child: Stack(children: [
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(image: NetworkImage(images[index]), fit: BoxFit.cover)),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          height: 30.sp,
                                          width: double.infinity,
                                          color: Colors.white70,
                                          child: Center(
                                              child: Text(litems[index],
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold))))))
                            ])));
                      }))
            ])));
  }

  topDeals() {
    List<String> litems = [
      "Lotte Choco Pie Creamfilled Biscuit 336",
      "Dove Nutritive Solutions Intense",
      "Surf Excel Easy wash Detergent Powder 4 kg",
      "Dabour Honey 500 g",
      "Lux Lotus Soap 200 g + 10% Extra",
      "Laxmi Bhog Besan"
    ];
    List<String> images = [
      "https://cdn.shopify.com/s/files/1/2649/4616/products/21.2_Lotte_Choco_Pie_336_gm_PRICE_140_1024x1024@2x.jpg?v=1608186737",
      "https://www.bigbasket.com/media/uploads/p/xxl/40141852_5-dove-hair-fall-rescue-shampoo.jpg",
      "https://5.imimg.com/data5/KS/UI/MY-47131030/surf-excel-quickwash-500x500.jpg",
      "https://www.cureka.com/wp-content/uploads/2019/12/Dabur-Honey-100g-600x600.jpg",
      "https://dropbasket.in/wp-content/uploads/2020/10/lux.jpg",
      "https://5.imimg.com/data5/FU/UD/MY-16520432/laxmi-bhog-besan-500x500.png"
    ];

    return Container(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.only(left: 10.sp),
                  child: Text("Top Deals",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold))),
              Container(
                  height: 210.h,
                  child: ListView.builder(
                      itemCount: litems.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: 110.h,
                            height: 200.h,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(index == 0 ? 10.h : 0, 10.h, 10.h, 0),
                              child: Column(children: [
                                Container(
                                    width: 100.h,
                                    height: 100.h,
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(image: NetworkImage(images[index]), fit: BoxFit.cover))),
                                Expanded(
                                    child: Center(
                                  child: RichText(
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          text: '₹ 22.50 ',
                                          style: TextStyle(
                                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.sp),
                                          children: [
                                            TextSpan(
                                                text: '₹ 45.00 \n',
                                                style: TextStyle(
                                                    decoration: TextDecoration.lineThrough,
                                                    color: Colors.black,
                                                    fontSize: 10.sp)),
                                            TextSpan(
                                                text: "Save ₹ 22.50 \n",
                                                style: TextStyle(
                                                    fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.green)),
                                            TextSpan(
                                                text: litems[index],
                                                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold))
                                          ])),
                                )),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.sp),
                                        side: BorderSide(color: Myapp.primaryColor)),
                                    onPressed: () {},
                                    elevation: 0,
                                    color: Myapp.primaryColor,
                                    textColor: Colors.white,
                                    padding: EdgeInsets.all(0.h),
                                    child: SizedBox(
                                        width: double.infinity,
                                        child: Text("Add".toUpperCase(),
                                            style: TextStyle(fontSize: 12.sp), textAlign: TextAlign.center)))
                              ]),
                            ));
                      }))
            ])));
  }

  shopGroceries() {
    List<String> litems = [
      "Lotte Choco Pie Creamfilled Biscuit 336",
      "Dove Nutritive Solutions Intense",
      "Surf Excel Easy wash Detergent Powder 4 kg",
      "Dabour Honey 500 g",
      "Lux Lotus Soap 200 g + 10% Extra",
      "Laxmi Bhog Besan"
    ];
    List<String> images = [
      "https://cdn.shopify.com/s/files/1/2649/4616/products/21.2_Lotte_Choco_Pie_336_gm_PRICE_140_1024x1024@2x.jpg?v=1608186737",
      "https://www.bigbasket.com/media/uploads/p/xxl/40141852_5-dove-hair-fall-rescue-shampoo.jpg",
      "https://5.imimg.com/data5/KS/UI/MY-47131030/surf-excel-quickwash-500x500.jpg",
      "https://www.cureka.com/wp-content/uploads/2019/12/Dabur-Honey-100g-600x600.jpg",
      "https://dropbasket.in/wp-content/uploads/2020/10/lux.jpg",
      "https://5.imimg.com/data5/FU/UD/MY-16520432/laxmi-bhog-besan-500x500.png"
    ];

    return Container(
        color: Colors.grey[200],
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.only(left: 10.sp),
                  child: Text("Shop Groceries",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold))),
              Container(
                  height: 70.h,
                  child: ListView.builder(
                      itemCount: litems.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: 170.h,
                            height: 90.h,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(index == 0 ? 10.h : 0, 10.h, 10.h, 0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.h))),
                                    child: Padding(
                                        padding: EdgeInsets.all(5.h),
                                        child: Row(children: [
                                          Container(
                                              width: 50.h,
                                              height: 50.h,
                                              alignment: Alignment.bottomCenter,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(3.h),
                                                  image: DecorationImage(
                                                      image: NetworkImage(images[index]), fit: BoxFit.cover))),
                                          Expanded(
                                              child: Center(
                                                  child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                                                      child: Text(litems[index],
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(fontSize: 12.sp)))))
                                        ])))));
                      }))
            ])));
  }

  offerListWithCategories() {
    List<String> titles = [
      "Top deals for you",
      "Best deals for you",
      "Exclusive deals for you",
      "Top deals for you",
      "Best deals for you",
      "Exclusive deals for you"
    ];

    List<Color> colors = [
      Colors.blueAccent,
      Colors.deepOrangeAccent[100],
      Colors.yellow[200],
      Colors.greenAccent[100],
      Colors.redAccent[100],
      Colors.deepPurple[200]
    ];

    List<Color> textcolors = [
      Colors.blueAccent[700],
      Colors.deepOrangeAccent[700],
      Colors.yellow[900],
      Colors.greenAccent[700],
      Colors.redAccent[700],
      Colors.deepPurple[700]
    ];

    List<String> litems = [
      "ATTA, Flours & Sooji",
      "Edible Oils",
      "Biscuits",
      "Hair Care",
      "Soaps",
      "Kid's Wear",
      "Men's Wear",
      "Women's Wear"
    ];

    List<String> images = [
      "https://www.abeautifulplate.com/wp-content/uploads/2017/03/bread-flour-differnet-types-of-flour.jpg",
      "https://2.imimg.com/data2/OW/NJ/MY-3998144/2006020900280402-500x500.jpg",
      "https://bsmedia.business-standard.com/_media/bs/img/article/2018-02/18/full/1518965938-4605.jpg",
      "https://i.pinimg.com/736x/3e/71/86/3e7186bd207e26279a8d17d320532238.jpg",
      "https://dropbasket.in/wp-content/uploads/2020/10/lux.jpg",
      "https://i1.wp.com/www.wholesalecatalog.in/wp-content/uploads/formidable/6/291.jpg?w=936&h=1405&ssl=1",
      "https://st.depositphotos.com/1007995/1274/i/950/depositphotos_12746726-stock-photo-fashion-man-wearing-sunglasses-thinking.jpg",
      "https://ae01.alicdn.com/kf/HTB17NWQh5FTMKJjSZFAq6AkJpXa1/Winter-Big-Pendulum-Purple-Velvet-Dresses-Woman-Dress-2020-Lotus-Leaf-Long-Sleeve-Ladies-Dresses-Kleider.jpg_q50.jpg"
    ];

    return ListView.builder(
        itemCount: titles.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              color: Colors.grey[200],
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                        padding: EdgeInsets.only(left: 10.sp),
                        child: Text(titles[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold))),
                    freeHomeDeliverySlider(grocerySlider),
                    Container(
                        color: colors[index],
                        child: Column(children: [
                          Padding(
                              padding: EdgeInsets.all(10.h),
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30.h), bottomRight: Radius.circular(30.h))),
                                  child: Padding(
                                      padding: EdgeInsets.all(10.sp),
                                      child: Text("Offers on daily essentials".toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.red))))),
                          Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.85,
                                      crossAxisSpacing: 30.sp,
                                      mainAxisSpacing: 30.sp),
                                  itemCount: litems.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index1) {
                                    return Container(
                                        child: Stack(children: [
                                      Container(
                                          alignment: Alignment.bottomCenter,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(images[index1]), fit: BoxFit.cover)),
                                          child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                  height: 40.sp,
                                                  width: double.infinity,
                                                  // color: Colors.white70,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.only(
                                                          bottomLeft: Radius.circular(10),
                                                          bottomRight: Radius.circular(10))),
                                                  child: Center(
                                                      child: RichText(
                                                          maxLines: 4,
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                          text: TextSpan(
                                                              text: 'UP TO ',
                                                              style: TextStyle(
                                                                  color: textcolors[index],
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15.sp),
                                                              children: [
                                                                TextSpan(
                                                                    text: '30% OFF\n',
                                                                    style: TextStyle(
                                                                        color: Colors.red,
                                                                        fontSize: 15.sp,
                                                                        fontWeight: FontWeight.bold)),
                                                                TextSpan(
                                                                    text: litems[index1],
                                                                    style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 12.sp,
                                                                        fontWeight: FontWeight.bold))
                                                              ]))))))
                                    ]));
                                  }))
                        ]))
                  ])));
        });
  }

  collectionWithBestOffers() {
    List<String> litems = [
      "T-Shirts",
      "T-Shirts",
      "Biscuits",
      "Hair Care",
      "Soaps",
      "Kid's Wear",
      "Men's Wear",
      "Women's Wear"
    ];

    List<String> images = [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR55GHn90kw0F_QRPULPEM-0S-ZUwYaWzaNsQ&usqp=CAU",
      "http://static1.squarespace.com/static/5272b4d3e4b0acc66cb2ced3/562bee8de4b0b7066cf7a2bb/56410b1fe4b0250517e7fc1f/1447103265312/Todder+Fine+Jersey+Tee+Model.jpg?format=1500w",
      "https://bsmedia.business-standard.com/_media/bs/img/article/2018-02/18/full/1518965938-4605.jpg",
      "https://i.pinimg.com/736x/3e/71/86/3e7186bd207e26279a8d17d320532238.jpg",
      "https://dropbasket.in/wp-content/uploads/2020/10/lux.jpg",
      "https://i1.wp.com/www.wholesalecatalog.in/wp-content/uploads/formidable/6/291.jpg?w=936&h=1405&ssl=1",
      "https://st.depositphotos.com/1007995/1274/i/950/depositphotos_12746726-stock-photo-fashion-man-wearing-sunglasses-thinking.jpg",
      "https://ae01.alicdn.com/kf/HTB17NWQh5FTMKJjSZFAq6AkJpXa1/Winter-Big-Pendulum-Purple-Velvet-Dresses-Woman-Dress-2020-Lotus-Leaf-Long-Sleeve-Ladies-Dresses-Kleider.jpg_q50.jpg"
    ];

    return Container(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Column(children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Collection With Best Offers",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 0.85, crossAxisSpacing: 10.sp, mainAxisSpacing: 10.sp),
                      itemCount: litems.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () =>
                                Navigator.push(context, MaterialPageRoute(builder: (_) => SubcategoryDetails())),
                            child: Container(
                                child: Stack(children: [
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.sp),
                                      image: DecorationImage(image: NetworkImage(images[index]), fit: BoxFit.cover)),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                                        Divider(height: 0.5.sp, color: Colors.black, thickness: 0.5.sp),
                                        Container(
                                            height: 20.sp,
                                            width: double.infinity,
                                            color: Colors.white70,
                                            child: Center(
                                                child: Text(litems[index],
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold)))),
                                        Divider(height: 0.5.sp, color: Colors.black, thickness: 0.5.sp),
                                        Container(
                                            height: 20.sp,
                                            width: double.infinity,
                                            color: Colors.white70,
                                            child: Center(
                                                child: RichText(
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                        text: 'Starting at ',
                                                        style: TextStyle(color: Colors.black, fontSize: 11.sp),
                                                        children: [
                                                          TextSpan(
                                                              text: '₹145',
                                                              style: TextStyle(
                                                                  fontSize: 11.sp, fontWeight: FontWeight.bold))
                                                        ])))),
                                        SizedBox(height: 10.sp)
                                      ])))
                            ])));
                      }))
            ])));
  }

  kidsFashion() {
    List<String> litems = [
      "Leggings",
      "Track Pants",
      'Shorts',
      'Tshirts',
      'Shirts',
    ];

    List<String> images = [
      "https://www.jiomart.com/images/cms/section/category/246/587.png?v=1612275415",
      "https://www.jiomart.com/images/cms/section/category/246/501.png?v=1612275415",
      'https://www.jiomart.com/images/cms/section/category/246/533.png?v=1612275415',
      'https://www.jiomart.com/images/cms/section/category/246/507.png?v=1612275415',
      'https://www.jiomart.com/images/cms/section/category/246/549.png?v=1612275415',
    ];

    return Container(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Column(children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Kid's fashion",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 0.80, crossAxisSpacing: 10.sp, mainAxisSpacing: 10.sp),
                      itemCount: litems.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () =>
                                Navigator.push(context, MaterialPageRoute(builder: (_) => SubcategoryDetails())),
                            child: Column(children: [
                              Expanded(
                                  child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.sp),
                                          image:
                                              DecorationImage(image: NetworkImage(images[index]), fit: BoxFit.cover)))),
                              Container(
                                  height: 20.sp,
                                  width: double.infinity,
                                  child: Center(
                                      child: Text(litems[index],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold))))
                            ]));
                      }))
            ])));
  }
}
