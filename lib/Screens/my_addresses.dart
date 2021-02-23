import 'package:e_commerce/Screens/add_address.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAddress extends StatefulWidget {
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  List<AddressDetail> addresses = [
    AddressDetail(
        name: "Krishna Softweb",
        type: "work",
        address: "208, Siddhivinayak platinum, Althan Road",
        mobileNo: "8758431417",
        pinCode: "394221",
        city: "Surat",
        state: "Gujarat"),
    AddressDetail(
        name: "Gaurav",
        type: "home",
        address: "46, Apeksha Nagar, Althan Road",
        mobileNo: "8758431417",
        pinCode: "394221",
        city: "Surat",
        state: "Gujarat")
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text("Address", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)), automaticallyImplyLeading: true),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton.icon(
                  minWidth: double.infinity,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress())),
                  height: 55,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7), side: BorderSide(color: Colors.grey[500], width: 2)),
                  icon: Icon(Icons.add, color: Myapp.primaryColor),
                  label:
                      Text("Add New Address", style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold)))),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (_, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 3),
                        padding: EdgeInsets.all(10),
                        height: 180,
                        width: size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2), borderRadius: BorderRadius.circular(7)),
                        child: Column(children: [
                          Expanded(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(addresses[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                  SizedBox(height: 5),
                                  Text("${addresses[index].address}",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Text("${addresses[index].city} - ${addresses[index].pinCode}",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Text(addresses[index].state,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Text(addresses[index].mobileNo,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey))
                                ])),
                                Container(
                                    padding: EdgeInsets.all(4),
                                    child: Text(addresses[index].type.toUpperCase(),
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey[300]))
                              ])),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: FlatButton(
                                  child: Text("Modify", style: TextStyle(color: Myapp.primaryColor)),
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddAddress(
                                                addressDetail: addresses[index],
                                              )))))
                        ]));
                  },
                  itemCount: addresses.length,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  physics: BouncingScrollPhysics()))
        ]));
  }
}

class AddressDetail {
  final String name, mobileNo, address, pinCode, state, city, type;

  AddressDetail({this.name, this.mobileNo, this.address, this.pinCode, this.state, this.city, this.type});
}
