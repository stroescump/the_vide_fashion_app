import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_vide/models/Product.dart';
import 'package:the_vide/widgets/product_type_cards.dart';

import 'TopMenu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> productsAvailable = [
    new Product(
        "Imperfect is fine.",
        124.99,
        "100% organic cotton, finest quality." +
            "Printed with water-based inks to allow the material to breathe" +
            "and for increased washability.",
        [
          "assets/images/FRONT_TEE.png",
          "assets/images/FRONT_TEE_DETAILS.png",
          "assets/images/BACK_TEE_DETAILS.png",
        ],
        "RON"),
    new Product(
        "Imperfect is fine.",
        124.99,
        "100% organic cotton, finest quality." +
            "Printed with water-based inks to allow the material to breathe" +
            "and for increased washability.",
        [
          "assets/images/FRONT_TEE.png",
          "assets/images/FRONT_TEE_DETAILS.png",
          "assets/images/BACK_TEE_DETAILS.png",
        ],
        "RON"),
    new Product(
        "Imperfect is fine.",
        124.99,
        "100% organic cotton, finest quality." +
            "Printed with water-based inks to allow the material to breathe" +
            "and for increased washability.",
        [
          "assets/images/FRONT_TEE.png",
          "assets/images/FRONT_TEE_DETAILS.png",
          "assets/images/BACK_TEE_DETAILS.png",
        ],
        "RON"),
  ];

  @override
  Widget build(BuildContext context) {
    print(productsAvailable[0].imgUrl[0]);
    return Scaffold(
        body: Column(
      children: <Widget>[
        TopMenu(),
        Flexible(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              ProductTypeCards(productsAvailable, "T-shirts"),
              ProductTypeCards(productsAvailable, "Hoodies"),
            ],
          ),
        )
      ],
    ));
  }
}
