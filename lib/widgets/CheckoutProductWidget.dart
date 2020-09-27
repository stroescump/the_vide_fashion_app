import 'package:flutter/material.dart';
import 'package:the_vide/models/ProductCart.dart';

import 'ProductDetails.dart';

class CheckoutProduct extends StatelessWidget {
  final ProductCart _productCart;

  static TextStyle checkoutTextStylePrimary = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w500,
      fontSize: 18,
      decoration: TextDecoration.none,
      color: ProductDetails.productDetailAccentColor);

  static TextStyle checkoutTextStyleSecondary = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w500,
      fontSize: 15,
      decoration: TextDecoration.none,
      color: ProductDetails.productDetailAccentColor.withOpacity(.5));

  CheckoutProduct(this._productCart);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            _productCart.product.imgUrl[1],
            width: 100,
            height: 100,
          ),
          Spacer(),
          Column(
            children: [
              Text(
                "No. of items: " + _productCart.quantity.toString(),
                style: CheckoutProduct.checkoutTextStylePrimary,
              ),
              Text(
                "Size: " + _productCart.sizeOfProduct,
                style: CheckoutProduct.checkoutTextStylePrimary,
              ),
              Text(
                "Price: " +
                    (_productCart.quantity * _productCart.product.price)
                        .toStringAsFixed(2) +
                    " RON",
                style: CheckoutProduct.checkoutTextStyleSecondary,
              )
            ],
          )
        ],
      ),
    );
  }
}
