import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:the_vide/models/CartNotifier.dart';
import 'package:the_vide/models/ProductCart.dart';
import 'package:the_vide/widgets/CheckoutShippingWidget.dart';
import 'package:the_vide/widgets/ProductCard.dart';

import 'ProductDetails.dart';

class CartWidget extends StatefulWidget {
  static final Color cartWidgetPrimaryColor = Color(0xffEAE1E3);
  static final Color cartWidgetAccentColor = Color(0xff2B1327);
  static final TextStyle primaryTextStyle = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w500,
      fontSize: 20,
      decoration: TextDecoration.none,
      color: ProductDetails.productDetailAccentColor);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextStyle primaryTextStyleBold = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w800,
      fontSize: 20,
      decoration: TextDecoration.none,
      color: Color(0xff853D5F));

  final TextStyle primaryTextBoldBig = TextStyle(
      fontFamily: 'Nunito',
      letterSpacing: -1,
      fontWeight: FontWeight.w600,
      fontSize: 35,
      decoration: TextDecoration.none,
      color: Color(0xff853D5F));

  double getTotalToPay(UnmodifiableListView<ProductCart> cartProducts) {
    double totalPrice = 0;

    for (int i = 0; i < cartProducts.length; i++) {
      totalPrice += cartProducts[i].product.price * cartProducts[i].quantity;
    }
    return totalPrice;
  }

  bool verifyIfCartIsEmpty(List<ProductCart> cartProducts) {
    if (cartProducts.isNotEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    int numberOfItemsInCart = Provider.of<CartNotifier>(context, listen: false)
        .getItemsFromCart
        .length;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 60, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_upward,
                        size: 20,
                        color: ProductDetails.arrowBackColor,
                      ),
                    ),
                  ),
                  Consumer<CartNotifier>(
                    builder: (context, cart, child) {
                      return GestureDetector(
                        onTap: () {
                          cart.removeAllProductsFromCart();
                          setState(() {
                            numberOfItemsInCart = 0;
                          });
                        },
                        child: RotatedBox(
                          quarterTurns: 0,
                          child: Icon(
                            Icons.delete,
                            size: 20,
                            color: ProductDetails.arrowBackColor,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text(
                    "My bag - ",
                    style: primaryTextBoldBig,
                  ),
                  Text(
                    numberOfItemsInCart.toString() + " items",
                    style: primaryTextBoldBig,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Consumer<CartNotifier>(
                  builder: (context, cart, child) {
                    if (!verifyIfCartIsEmpty(cart.getItemsFromCart)) {
                      print(getTotalToPay(cart.getItemsFromCart));
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: cart.getItemsFromCart
                              .map((cartProduct) => GestureDetector(
                                    onTap: () {
                                      print("Deleted!");
                                      cart.removeItem(cartProduct);
                                    },
                                    child: ProductCard(Key("cartProduct"),
                                        cartProduct.product, true, cartProduct),
                                  ))
                              .toList(),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Container(
              child: Consumer<CartNotifier>(
                builder: (context, cart, child) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: 40, right: 40, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total",
                          style: CartWidget.primaryTextStyle,
                        ),
                        Spacer(),
                        Text(
                          getTotalToPay(cart.getItemsFromCart)
                                  .toStringAsFixed(2) +
                              " RON",
                          style: CartWidget.primaryTextStyle,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: size.width * .85,
              height: size.height / 13,
              decoration: BoxDecoration(
                color: Color(0xffFCD4DF),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  width: 1,
                  color: Color(0xff853D5F),
                ),
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CheckoutShippingWidget();
                    },
                  ));
                },
                child: Text(
                  "Checkout",
                  style: primaryTextStyleBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
