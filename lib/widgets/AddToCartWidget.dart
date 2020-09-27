import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_vide/models/CartNotifier.dart';
import 'package:the_vide/models/Product.dart';
import 'package:the_vide/models/ProductCart.dart';

import 'ProductDetails.dart';

class AddToCartWidget extends StatelessWidget {
  final Product selectedProduct;
  final String selectedSize;
  final int quantity;
  static TextStyle snackBarAlertTextStyle = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w500,
      fontSize: 15,
      decoration: TextDecoration.none,
      color: ProductDetails.productDetailAccentColor);

  AddToCartWidget(this.selectedProduct, this.quantity, this.selectedSize);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.selectedSize != ProductDetails.EMPTY_SIZE_CHOICE &&
            this.selectedSize != ProductDetails.TOO_MANY_SIZE_CHOICES) {
          ProductCart productToBeAddedToCart =
              new ProductCart(selectedProduct, quantity, selectedSize);
          print(productToBeAddedToCart.toString());
          Provider.of<CartNotifier>(context, listen: false)
              .addItemToCart(productToBeAddedToCart);
          showToast("Product has been added successfully!", context);
        } else {
          showToast("Make sure you have one option selected.", context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: ProductDetails.purchaseBarPrimaryColor.withOpacity(1),
          borderRadius: BorderRadius.circular(5),
        ),
        height: 35,
        width: 150,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Add to cart",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                FontAwesomeIcons.cartPlus,
                size: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showToast(String s, BuildContext context) {
    final snackScaffold = Scaffold.of(context);
    snackScaffold.showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: ProductDetails.purchaseBarPrimaryColor,
      content: Text(s, style: AddToCartWidget.snackBarAlertTextStyle),
    ));
  }
}
