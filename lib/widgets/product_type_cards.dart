import 'package:flutter/material.dart';
import 'package:the_vide/models/Product.dart';
import 'package:the_vide/widgets/cards.dart';

class ProductTypeCards extends StatelessWidget {
  final List<Product> productsAvailable;
  final String productType;

  ProductTypeCards(this.productsAvailable, this.productType);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20, left: 30, bottom: 5),
          child: Text(
            productType,
            style: TextStyle(
                letterSpacing: -0.9,
                color: Colors.pink[900],
                fontFamily: 'Averta',
                fontWeight: FontWeight.w500,
                fontSize: 30.0),
          ),
        ),
        Container(
          width: double.infinity,
          height: 280,
          padding: const EdgeInsets.only(top: 5, bottom: 0),
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: productsAvailable
                  .map((p) => ProductCard(imgUrl: p.imgUrl))
                  .toList()),
        ),
      ],
    );
  }
}
