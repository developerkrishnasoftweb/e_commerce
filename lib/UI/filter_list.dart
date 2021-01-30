import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'category.dart';

class FilterList extends StatefulWidget {
  @override
  _FilterListState createState() => _FilterListState();
}

enum FilteredLists {
  ONLY_COD_PRODUCTS,
  PRICE,
  DISCOUNT_PERCENT,
  RATTING,
  CATEGORY,
  DESIGNER,
  TYPE,
  SAREE_COLOR,
  FABRIC_OF_SAREE,
  LOOK,
  WORK,
  OCCASION
}

class _FilterListState extends State<FilterList> {
  List filterData = [];
  List filteredData = [];
  List<Map<String, dynamic>> filteredList = [
    {
      "filterTitle": "Only COD Products",
      "filterList": [
        "\$1 to \$500 (11595)",
        "\$501 to \$1000 (1195)",
        "\$1001 to \$2000 (1295)",
        "\$2001 to \$4000 (1295)"
      ]
    },
    {
      "filterTitle": "PRICE",
      "filterList": [
        "Above 1000",
        "Above 2000",
        "Above 3000",
        "Above 4000",
        "Above 5000"
      ]
    },
    {
      "filterTitle": "Discount Percent",
      "filterList": ["10 %", "20 %", "30 %"]
    },
    {
      "filterTitle": "Ratting",
      "filterList": ["4", "5", "3"]
    },
    {
      "filterTitle": "Category",
      "filterList": ["Men's wear", "Women's wear", "Child wear"]
    },
    {
      "filterTitle": "Designer",
      "filterList": [
        "\$1 to \$500 (11595)",
        "\$501 to \$1000 (1195)",
        "\$1001 to \$2000 (1295)",
        "\$2001 to \$4000 (1295)"
      ]
    },
    {
      "filterTitle": "Type",
      "filterList": [
        "\$1 to \$500 (11595)",
        "\$501 to \$1000 (1195)",
        "\$1001 to \$2000 (1295)",
        "\$2001 to \$4000 (1295)"
      ]
    },
    {
      "filterTitle": "Saree Color",
      "filterList": [
        "\$1 to \$500 (11595)",
        "\$501 to \$1000 (1195)",
        "\$1001 to \$2000 (1295)",
        "\$2001 to \$4000 (1295)"
      ]
    },
    {
      "filterTitle": "Fabric of Saree",
      "filterList": [
        "\$1 to \$500 (11595)",
        "\$501 to \$1000 (1195)",
        "\$1001 to \$2000 (1295)",
        "\$2001 to \$4000 (1295)"
      ]
    },
    {
      "filterTitle": "Look",
      "filterList": [
        "\$1 to \$500 (11595)",
        "\$501 to \$1000 (1195)",
        "\$1001 to \$2000 (1295)",
        "\$2001 to \$4000 (1295)"
      ]
    },
    {
      "filterTitle": "Work",
      "filterList": [
        "\$1 to \$500 (11595)",
        "\$501 to \$1000 (1195)",
        "\$1001 to \$2000 (1295)",
        "\$2001 to \$4000 (1295)"
      ]
    },
    {
      "filterTitle": "Occasion",
      "filterList": [
        "\$1 to \$500 (11595)",
        "\$501 to \$1000 (1195)",
        "\$1001 to \$2000 (1295)",
        "\$2001 to \$4000 (1295)"
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: appBarIconButton(
            imagePath: "assets/icons/left-arrow.png",
            color: Colors.white,
            onPressed: () => Navigator.pop(context)),
        title: Text(
          "Filters",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Color(0xff4E72D4),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Container(
                height: size.height,
                width: size.width * 0.5,
                margin: EdgeInsets.only(bottom: 80),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, i) {
                    return ListTile(
                      title: Text(filteredList[i]["filterTitle"]),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        setState(() {
                          filterData = filteredList[i]["filterList"];
                        });
                      },
                    );
                  },
                  itemCount: filteredList.length,
                ),
              ),
              Container(
                height: size.height,
                width: size.width * 0.5,
                margin: EdgeInsets.only(bottom: 80),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, i) {
                    return RadioListTile(
                      onChanged: (value) {
                        setState(() {});
                      },
                      groupValue: filterData,
                      value: filterData[i],
                      title: Text(filterData[i]),
                    );
                  },
                  itemCount: filterData.length,
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 80,
                width: size.width,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "CLEAR",
                          style: TextStyle(color: Colors.black),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.black)),
                        padding: EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "APPLY",
                          style: TextStyle(color: Colors.black),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.black)),
                        padding: EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
