import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/Models/AllCategories.dart';
import 'package:e_commerce/Models/AllCollection.dart';
import 'package:e_commerce/Models/Banners.dart';
import 'package:e_commerce/Models/BestOffer.dart';
import 'package:e_commerce/Models/MainCategory.dart';
import 'package:e_commerce/Models/ProductsById.dart';
import 'package:e_commerce/Models/rest_api.dart';
import 'package:e_commerce/Screens/CartScreen.dart';
import 'package:e_commerce/Screens/home/SubCategoryDetailsGrocery.dart';
import 'package:e_commerce/Screens/home/TopCategoryDetails.dart';
import 'package:e_commerce/Screens/home/widgets/AddtoCartButton.dart';
import 'package:e_commerce/constant/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../NavigationDrawer.dart';
import 'AllCategoryDetailHorizontal.dart';
import 'BannerDetails.dart';
import 'ProductDetail.dart';
import 'ProductList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Banners topCategoryBanners, bestDealsBanners, topDealsBanners, exclusiveDealsBanners;
  MainCategory topCategory;
  AllCategory mainCategory;
  AllCategory shopGrocery, kidsFashionData;
  ProductsById topProducts;
  BestOffers bestOffers;
  AllCollection offers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.sp,
            title: Text("Pal", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            elevation: 0,
            actions: [
              IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen())))
            ]),
        // leading: IconButton(icon: ImageIcon(AssetImage("assets/icons/left-arrow.png"), color: Colors.white))),
        drawer: navigationDrawer(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          searchBarView(),
          FutureBuilder(
              future: Future.wait([
                ApiService.getBannersTopCategory(),
                ApiService.getBannersBestDeals(),
                ApiService.getBannersTopDeals(),
                ApiService.getBannersExclusiveDeals(),
                ApiService.getHomeCategories(),
                ApiService.getTopCategories(),
                ApiService.getTopProducts(),
                ApiService.getGroceries(),
                ApiService.getBestOfferCollection(),
                ApiService.getKidsFashion(),
                ApiService.getOffers1()
              ]),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  throw (snapshot.error);
                }
                if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                  topCategoryBanners = snapshot.data[0];
                  bestDealsBanners = snapshot.data[1];
                  topDealsBanners = snapshot.data[2];
                  exclusiveDealsBanners = snapshot.data[3];
                  mainCategory = snapshot.data[4];
                  topCategory = snapshot.data[5];
                  topProducts = snapshot.data[6];
                  shopGrocery = snapshot.data[7];
                  bestOffers = snapshot.data[8];
                  kidsFashionData = snapshot.data[9];
                  offers = snapshot.data[10];

                  return Expanded(
                      child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(children: [
                            mainCategory != null ? categoriesListHorizontal(mainCategory.data) : Container(),
                            topCategoryBanners != null ? freeHomeDeliverySlider(topCategoryBanners.data) : Container(),
                            topCategory != null ? topCategories(topCategory.data) : Container(),
                            topProducts != null ? topDeals(topProducts.data) : Container(),
                            shopGrocery != null ? shopGroceries(shopGrocery.data) : Container(),
                            offers != null ? offerListWithCategories() : Container(),
                            bestOffers != null ? collectionWithBestOffers(bestOffers) : Container(),
                            kidsFashionData != null ? kidsFashion(kidsFashionData.data) : Container()
                          ])));
                } else
                  return Expanded(child: Container(color: Colors.white, child: Center(child: CircularProgressIndicator())));
              })
        ]));
  }

  Widget categoriesListHorizontal(List<MainData> data) => Padding(
      padding: EdgeInsets.only(top: 10.sp),
      child: Container(
          height: 100.sp,
          child: ListView.builder(
              itemCount: data.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              primary: false,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => AllCategoryDetailHorizontal(id: index, list: data))),
                    child: Container(
                        width: 70.sp,
                        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 25.sp,
                                  backgroundImage: NetworkImage(URLS.PAL_IMAGE_URL + data[index].image),
                                  backgroundColor: Colors.transparent),
                              Center(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                                      child: Text(data[index].name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15.sp))))
                            ])));
              })));

  Widget searchBarView() => Container(
      color: Myapp.primaryColor,
      child: Padding(
          padding: EdgeInsets.fromLTRB(10.ssp, 0, 10.ssp, 10.ssp),
          child: TextField(
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.all(10.sp),
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5.ssp)),
                  hintText: "Search for Products and Brand"))));

  freeHomeDeliverySlider(List<Data> data) => CarouselSlider(
      options: CarouselOptions(autoPlay: true, aspectRatio: 2.0, enlargeCenterPage: true), items: imageSlideView(data));

  imageSlideView(List<Data> data) => data
      .map((item) => GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BannerDetails(id: item.linkUrl))),
          child: Container(
              child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(children: <Widget>[
                        Image.network(URLS.IMAGE_URL + "/" + item.image, fit: BoxFit.cover, width: 800.sp, height: 400.sp)
                      ]))))))
      .toList();

  topCategories(List<Categories> data) => Container(
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
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () => Navigator.push(
                              context, MaterialPageRoute(builder: (_) => TopCategoryDetails(id: index, list: data))),
                          child: Container(
                              child: Stack(children: [
                            Container(
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(URLS.IMAGE_URL + "/" + data[index].banner_image), fit: BoxFit.cover)),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        height: 30.sp,
                                        width: double.infinity,
                                        color: Colors.white70,
                                        child: Center(
                                            child: Text(data[index].name,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold))))))
                          ])));
                    }))
          ])));

  topDeals(List<Products> data) {
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
                      itemCount: data.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {

                        return GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetail(data[index]))),
                            child: Container(
                                width: 110.h,
                                height: 200.h,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(index == 0 ? 10.h : 0, 10.h, 10.h, 0),
                                    child: Column(children: [
                                      Stack(children: [
                                        Container(
                                            width: 100.h,
                                            height: 100.h,
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(URLS.PAL_IMAGE_URL +
                                                        "/pub/media/catalog/product" +
                                                        data[index].images[0].file),
                                                    fit: BoxFit.cover))),
                                        data[index].attributes.specialPrice != "0" && data[index].price != 0
                                            ? Transform.rotate(
                                                angle: -math.pi / 6,
                                                child: Stack(children: [
                                                  Image.asset('assets/badge.png', width: 40.sp, height: 40.sp),
                                                  Container(
                                                      width: 40.sp,
                                                      height: 40.sp,
                                                      child: Center(
                                                          child: Text(getDiscountPercentage(data[index]),
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 10.sp,
                                                                  fontWeight: FontWeight.bold),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis)))
                                                ]))
                                            : Container()
                                      ]),
                                      Expanded(
                                          child: Center(
                                              child: RichText(
                                                  maxLines: 4,
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(
                                                      text: getPrice(data[index]) +" ",
                                                      style: TextStyle(
                                                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.sp),
                                                      children: [
                                                        TextSpan(
                                                            text: getMRP(data[index]) +"\n",
                                                            style: TextStyle(
                                                                decoration: TextDecoration.lineThrough,
                                                                color: Colors.black,
                                                                fontSize: 10.sp)),
                                                        TextSpan(
                                                            text: getSavingPrice(data[index]) + "\n",
                                                            style: TextStyle(
                                                                fontSize: 10.sp,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.green)),
                                                        TextSpan(
                                                            text: data[index].name,
                                                            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold))
                                                      ])))),
                                      SizedBox(height: 10),
                                      SizedBox(height: 32, width: double.infinity, child: AddtoCartButton(data[index], "ADD"))
                                    ]))));
                      }))
            ])));
  }

  shopGroceries(List<MainData> data) {
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
                      itemCount: data[0].subCategories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SubCategoryDetailsGrocery(id: index, list: data[0].subCategories))),
                            child: Container(
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
                                                          image: NetworkImage(
                                                              URLS.PAL_IMAGE_URL + data[0].subCategories[index].image ?? ''),
                                                          fit: BoxFit.cover))),
                                              Expanded(
                                                  child: Center(
                                                      child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                                                          child: Text(data[0].subCategories[index].name,
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(fontSize: 12.sp)))))
                                            ]))))));
                      }))
            ])));
  }

  offerListWithCategories() {
    List<String> titles = ["Top deals for you", "Best deals for you", "Exclusive deals for you"];
    List<Banners> banners = [topDealsBanners, bestDealsBanners, exclusiveDealsBanners];

    List<Color> colors = [
      Colors.blueAccent,
      Colors.deepOrangeAccent[100],
      Colors.yellow[200],
      Colors.greenAccent[100],
      Colors.deepPurple[200]
    ];

    return ListView.builder(
        itemCount: offers.data.length,
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
                    freeHomeDeliverySlider(banners[index ~/ 3].data),
                    Container(
                        color: Color(int.parse(offers.data[index].backgroundColor)),
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
                                      child: Text(offers.data[index].title.toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.red))))),
                          Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 0.85, crossAxisSpacing: 30.sp, mainAxisSpacing: 30.sp),
                                  itemCount: offers.data[index].collections.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index1) {
                                    return GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    ProductList(id: offers.data[index].collections[index1].categoryId))),
                                        child: Container(
                                            child: Stack(children: [
                                          Container(
                                              alignment: Alignment.bottomCenter,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          URLS.IMAGE_URL + '/' + offers.data[index].collections[index1].image),
                                                      fit: BoxFit.cover)),
                                              child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Container(
                                                      height: 40.sp,
                                                      width: double.infinity,
                                                      // color: Colors.white70,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                                                      child: Center(
                                                          child: RichText(
                                                              maxLines: 4,
                                                              textAlign: TextAlign.center,
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                  text: 'UP TO ',
                                                                  style: TextStyle(
                                                                      color: Colors.blueAccent[700],
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15.sp),
                                                                  children: [
                                                                    TextSpan(
                                                                        text: offers.data[index].collections[index1].offerString +
                                                                            '\n',
                                                                        style: TextStyle(
                                                                            color: Colors.red,
                                                                            fontSize: 15.sp,
                                                                            fontWeight: FontWeight.bold)),
                                                                    TextSpan(
                                                                        text: offers.data[index].collections[index1].title,
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 12.sp,
                                                                            fontWeight: FontWeight.bold))
                                                                  ]))))))
                                        ])));
                                  }))
                        ]))
                  ])));
        });
  }

  collectionWithBestOffers(BestOffers bestOffers) {
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
                      itemCount: bestOffers.data.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context, MaterialPageRoute(builder: (_) => ProductList(id: bestOffers.data[index].categoryId))),
                            child: Container(
                                child: Stack(children: [
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.sp),
                                      image: DecorationImage(
                                          image: NetworkImage(URLS.IMAGE_URL + '/' + bestOffers.data[index].image),
                                          fit: BoxFit.cover)),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                                        Divider(height: 0.5.sp, color: Colors.black, thickness: 0.5.sp),
                                        Container(
                                            height: 20.sp,
                                            width: double.infinity,
                                            color: Colors.white70,
                                            child: Center(
                                                child: Text(bestOffers.data[index].title,
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
                                                              text: '₹' + bestOffers.data[index].offerString,
                                                              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold))
                                                        ])))),
                                        SizedBox(height: 10.sp)
                                      ])))
                            ])));
                      }))
            ])));
  }

  kidsFashion(List<MainData> data) {
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
                      itemCount: data[0].subCategories.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => ProductList(id: data[0].subCategories[index].id))),
                            child: Column(children: [
                              Expanded(
                                  child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.sp),
                                          image: DecorationImage(
                                              image: NetworkImage(URLS.PAL_IMAGE_URL + data[0].subCategories[index].image ?? ''),
                                              fit: BoxFit.cover)))),
                              Container(
                                  height: 20.sp,
                                  width: double.infinity,
                                  child: Center(
                                      child: Text(data[0].subCategories[index].name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold))))
                            ]));
                      }))
            ])));
  }
}
