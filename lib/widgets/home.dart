import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_vide/models/Product.dart';
import 'package:the_vide/widgets/product_type_cards.dart';
import 'package:the_vide/widgets/top_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> productsAvailable = [
    new Product("Tee1", 124.99, "Description1", "assets/images/FRONT_TEE.png"),
    new Product("Tee2", 130.99, "Description2", "assets/images/FRONT_TEE1.png"),
    new Product("Tee3", 150.99, "Description3", "assets/images/FRONT_TEE2.png"),
    new Product("Tee4", 190.00, "Description4", "assets/images/FRONT_TEE3.png"),
  ];
  @override
  Widget build(BuildContext context) {
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
