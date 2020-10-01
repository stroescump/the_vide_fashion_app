import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_vide/models/CartNotifier.dart';
import 'package:the_vide/models/Product.dart';
import 'package:the_vide/models/ProductCart.dart';
import 'package:the_vide/widgets/CheckoutProductWidget.dart';

import 'ProductDetails.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final ProductCart productCart;
  final bool isCartProduct;

  ProductCard(Key key, this.product, this.isCartProduct, this.productCart)
      : super();

  @override
  _ProductCardState createState() =>
      _ProductCardState(product, isCartProduct, productCart);
}

class _ProductCardState extends State<ProductCard> {
  _ProductCardState(product, _isCartProduct, productCart);

  bool isHeartPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isCartProduct) {
          Provider.of<CartNotifier>(context, listen: false)
              .removeItem(widget.productCart);
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductDetails(widget.product, widget.productCart)),
        );
      },
      // alignment is based on whether is a cart product or not, reused this class
      child: Container(
        height: widget.isCartProduct ? 220 : 100,
        width: widget.isCartProduct
            ? MediaQuery.of(context).size.width * 0.90
            : 190,
        padding: widget.isCartProduct ? EdgeInsets.zero : EdgeInsets.all(2),
        margin: widget.isCartProduct
            ? EdgeInsets.only(top: 5, bottom: 10)
            : EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xffFFC4CA).withOpacity(0.4),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
                color: Colors.pink[700].withOpacity(.1),
                blurRadius: !widget.isCartProduct ? 8 : 0,
                spreadRadius: !widget.isCartProduct ? 1.0 : 0,
                offset: !widget.isCartProduct ? Offset(0.0, 4.0) : Offset(0, 0))
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/textureBG.png"),
            ),
            color: Color(0xffFFC4CA).withOpacity(0.5),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: [
              Container(
                margin: widget.isCartProduct
                    ? EdgeInsets.zero
                    : EdgeInsets.only(left: 15),
                child: Stack(
                  overflow: Overflow.clip,
                  children: <Widget>[
                    Container(
//                    alignment: !widget.isCartProduct
//                        ? Alignment.center
//                        : Alignment.center,
                      padding: EdgeInsets.all(10),
                      margin: widget.isCartProduct
                          ? EdgeInsets.only(left: 40)
                          : EdgeInsets.zero,
                      child: Image.asset(
                        (widget.product.imgUrl[0]),
                      ),
                    ),
                    !widget.isCartProduct
                        ? Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isHeartPressed = !isHeartPressed;
                                });
                              },
                              icon: Icon(
                                isHeartPressed
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                size: 21,
                                color: isHeartPressed
                                    ? Colors.pink[600]
                                    : Colors.pink[400],
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              Spacer(),
              widget.productCart != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 30, bottom: 30),
                            child: CheckoutProduct(widget.productCart)),
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
