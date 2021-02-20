import 'package:e_commerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text("My Account",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)), automaticallyImplyLeading: true),
        body: SingleChildScrollView(
            child: Column(children: [
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
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 250,
            width: size.width,
            color: Myapp.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(70)),
                        child: Icon(
                          Icons.person,
                          color: Myapp.primaryColor,
                          size: 30,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Krishna Softweb",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 3,
                            ),
                            Text("krishnasoftweb@gmail.com",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 3,
                            ),
                            Text("+91-8758431417",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            profileButton(onPressed: (){}, icon: Icons.credit_card_outlined, label: "Payment Methods"),
                            SizedBox(
                              width: 10,
                            ),
                            profileButton(onPressed: (){}, icon: Icons.history, label: "Order History"),
                          ],
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        profileButton(onPressed: (){}, icon: Icons.location_on_rounded, label: "Delivery Address"),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          )
        ])));
  }
  Widget profileButton ({IconData icon, String label, @required VoidCallback onPressed}) {
    return Expanded(
      child: FlatButton(
          height: double.infinity,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          color: Colors.white38,
          child: Row(
            children: [
              Icon(icon,
                color: Colors.white, size: 20,),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                        color: Colors.white, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          )),
    );
  }
}
