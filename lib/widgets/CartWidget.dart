import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:the_vide/models/CartNotifier.dart';
import 'package:the_vide/models/ProductCart.dart';
import 'package:the_vide/widgets/CheckoutProductWidget.dart';

import 'ProductDetails.dart';

class CartWidget extends StatefulWidget {
  static TextStyle primaryTextStyle = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w500,
      fontSize: 20,
      decoration: TextDecoration.none,
      color: ProductDetails.productDetailAccentColor);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  double getTotalToPay(UnmodifiableListView<ProductCart> cartProducts) {
    double totalPrice = 0;

    for (int i = 0; i < cartProducts.length; i++) {
      totalPrice += cartProducts[i].product.price * cartProducts[i].quantity;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 60),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_upward,
                      size: 20,
                      color: ProductDetails.productDetailAccentColor,
                    ),
                  ),
                ),
              ),
              Consumer<CartNotifier>(
                builder: (context, cart, child) {
                  return GestureDetector(
                    onTap: () {
                      cart.removeAllProductsFromCart();
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 20, top: 60),
                      child: RotatedBox(
                        quarterTurns: 0,
                        child: Icon(
                          Icons.delete,
                          size: 20,
                          color: ProductDetails.productDetailAccentColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Your products",
            style: CartWidget.primaryTextStyle,
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Consumer<CartNotifier>(
              builder: (context, cart, child) {
                if (!verifyIfCartIsEmpty(cart.getItemsFromCart)) {
                  print(getTotalToPay(cart.getItemsFromCart));
                  return SingleChildScrollView(
                    child: Column(
                      children: cart.getItemsFromCart
                          .map((cartProduct) => CheckoutProduct(cartProduct))
                          .toList(),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Container(
            child: Consumer<CartNotifier>(
              builder: (context, cart, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Total: " +
                            getTotalToPay(cart.getItemsFromCart)
                                .toStringAsFixed(2) +
                            " RON",
                        style: CartWidget.primaryTextStyle,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            width: size.width,
            height: size.height / 10,
            decoration:
                BoxDecoration(color: ProductDetails.purchaseBarPrimaryColor),
            child: FlatButton(
              onPressed: () {},
              child: Text(
                "Checkout",
                style: CartWidget.primaryTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool verifyIfCartIsEmpty(List<ProductCart> cartProducts) {
    if (cartProducts.isNotEmpty) {
      return false;
    }
    return true;
  }
}
