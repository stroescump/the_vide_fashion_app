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
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _productCart.product.name,
            style: CheckoutProduct.checkoutTextStylePrimary,
          ),
          Text(
            "Size: " + _productCart.sizeOfProduct,
            style: CheckoutProduct.checkoutTextStylePrimary,
          ),
          SizedBox(width: 30),
          Text(
            "Qty." + _productCart.quantity.toString(),
            style: CheckoutProduct.checkoutTextStylePrimary,
          ),
          Row(
            children: [
              Text(
                "Price: " +
                    (_productCart.quantity * _productCart.product.price)
                        .toStringAsFixed(2) +
                    " RON",
                style: CheckoutProduct.checkoutTextStyleSecondary,
              ),
            ],
          )
        ],
      ),
    );
  }
}
