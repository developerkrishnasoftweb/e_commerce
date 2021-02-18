import 'package:flutter/material.dart';

class SubcategoryDetails extends StatefulWidget {
  @override
  _SubcategoryDetailsState createState() => _SubcategoryDetailsState();
}

class _SubcategoryDetailsState extends State<SubcategoryDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.account_circle, color: Colors.white), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Colors.grey[100],
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
            SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}
