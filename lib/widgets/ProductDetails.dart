import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_vide/models/Product.dart';
import 'package:the_vide/models/ProductCart.dart';
import 'package:the_vide/widgets/AddToCartWidget.dart';
import 'package:the_vide/widgets/ClothingSizeWidget.dart';

import 'CartWidget.dart';

class ProductDetails extends StatefulWidget {
  final Product _product;
  final ProductCart _productCart;
  static final Color purchaseBarPrimaryColor = Color(0xffC7AEC3);
  static final Color productDetailAccentColor = Color(0xff2B1327);
  static final Color productSizeAccentColor = Color(0xff2B1327);
  static final Color productSizeNotPressedBorderColor = Colors.pink[300];
  static final Color productSizePressedBorderColor = Colors.transparent;
  static final Color productSizePressedTextColor = Colors.white;
  static final Color productSizeNotPressedTextColor = Colors.pink[600];
  static final Color arrowBackColor = Colors.pink[900];
  static const String EMPTY_SIZE_CHOICE = "empty";

  Color get purchaseBarColor => purchaseBarPrimaryColor;

  Color get productDetailAccent => productDetailAccentColor;

  ProductDetails(this._product, this._productCart);

  @override
  _ProductDetailsState createState() => _ProductDetailsState(_productCart);
}

class _ProductDetailsState extends State<ProductDetails> {
  int _numberOfProducts = 1;
  bool _isPressedSsize = false;
  bool _isPressedMsize = false;
  bool _isPressedLsize = false;
  bool _isPressedXLsize = false;

  void populateFieldsIfNeeded() {
    if (widget._productCart != null) {
      setState(() {
        _numberOfProducts = widget._productCart.quantity;
      });
      switch (widget._productCart.sizeOfProduct) {
        case "S":
          setState(() {
            _isPressedSsize = true;
          });
          break;
        case "M":
          setState(() {
            _isPressedMsize = true;
          });
          break;
        case "L":
          setState(() {
            _isPressedLsize = true;
          });
          break;
        case "XL":
          setState(() {
            _isPressedXLsize = true;
          });
      }
    }
  }

  _ProductDetailsState(_productCart);

  String getSelectedSize() {
    if (_isPressedSsize) return "S";

    if (_isPressedMsize) return "M";

    if (_isPressedLsize) return "L";

    if (_isPressedXLsize) return "XL";

    return ProductDetails.EMPTY_SIZE_CHOICE;
  }

  bool _isSecondImageShown = false;

  bool get getIsSecondImageShown => _isSecondImageShown;

  Widget clothingSizeWidget() {
    populateFieldsIfNeeded();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                _isPressedSsize = !_isPressedSsize;
                _isPressedMsize = false;
                _isPressedLsize = false;
                _isPressedXLsize = false;
              });
            },
            child: ClothingSizeWidget("S", _isPressedSsize)),
        GestureDetector(
            onTap: () {
              setState(() {
                _isPressedMsize = !_isPressedMsize;
                _isPressedSsize = false;
                _isPressedLsize = false;
                _isPressedXLsize = false;
              });
            },
            child: ClothingSizeWidget("M", _isPressedMsize)),
        GestureDetector(
            onTap: () {
              setState(() {
                _isPressedLsize = !_isPressedLsize;
                _isPressedSsize = false;
                _isPressedMsize = false;
                _isPressedXLsize = false;
              });
            },
            child: ClothingSizeWidget("L", _isPressedLsize)),
        GestureDetector(
            onTap: () {
              setState(() {
                _isPressedXLsize = !_isPressedXLsize;
                _isPressedSsize = false;
                _isPressedMsize = false;
                _isPressedLsize = false;
              });
            },
            child: ClothingSizeWidget("XL", _isPressedXLsize)),
      ],
    );
  }

  Widget productNameAndPrice() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget._product.name,
            style: TextStyle(
                color: Color(0xff55254F),
                decoration: TextDecoration.none,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
                fontSize: 30.0),
          ),
          Text(
            widget._product.price.toString() + " " + widget._product.currency,
            style: TextStyle(
                color: Color(0xffB17CAA),
                decoration: TextDecoration.none,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  Widget addToCartBottomBar(Size size) {
    return Container(
      width: size.width * 0.9,
//            alignment: Alignment(-0.5,-0.5),
      height: size.height / 10,
      decoration: BoxDecoration(
        border: Border.all(color: widget.purchaseBarColor),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (_numberOfProducts > 1)
                setState(() {
                  _numberOfProducts--;
                });
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.purchaseBarColor.withOpacity(.70),
                borderRadius: BorderRadius.circular(5),
              ),
              width: 35,
              height: 35,
              alignment: Alignment.center,
              child: Icon(
                FontAwesomeIcons.minus,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              _numberOfProducts.toString(),
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color(0xff2B1327).withOpacity(0.85),
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _numberOfProducts++;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.purchaseBarColor.withOpacity(.70),
                borderRadius: BorderRadius.circular(5),
              ),
              width: 35,
              height: 35,
              alignment: Alignment.center,
              child: Icon(
                FontAwesomeIcons.plus,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 60,
          ),
          AddToCartWidget(
              widget._product, _numberOfProducts, getSelectedSize()),
        ],
      ),
    );
  }

  Widget goBackArrowWidget() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 45, right: 20),
      child: Row(
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
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartWidget()));
            },
            icon: Icon(
              Icons.shopping_cart,
              size: 20,
            ),
            color: Colors.pink[900],
          )
        ],
      ),
    );
  }

  Widget productWidget(Size size) {
    return GestureDetector(
      onHorizontalDragEnd: (e) {
        print('DRAG ENDED!');
        setState(() {
          _isSecondImageShown = !_isSecondImageShown;
          print(_isSecondImageShown);
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 40),
        width: size.width,
        height: size.height / 2,
        child: !_isSecondImageShown
            ? Image.asset(widget._product.imgUrl[1])
            : Image.asset(widget._product.imgUrl[2]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    alignment: Alignment.topLeft,
                    width: size.width,
                    height: size.height / 2,
                    decoration: BoxDecoration(
                      color: Colors.pink[100],
                    ),
                  ),
                ),
                productWidget(size),
                goBackArrowWidget(),
              ],
            ),
            DotsForImageIndex(isSecondImageShown: _isSecondImageShown),
            productNameAndPrice(),
            clothingSizeWidget(),
            Container(
              height: 30,
              margin: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      "Description",
                      style: TextStyle(
                          color: Color(0xff55254F),
                          decoration: TextDecoration.none,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                  ),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Icon(Icons.keyboard_arrow_up,
                          size: 20, color: Color(0xff55254F)))
                ],
              ),
            ),
            //TODO: THIS IS SO TIGANIE, PUSHED THE PURCHASE BAR DOWN USING THIS...
            SizedBox(height: 10),
            //TODO: PURCHASE BAR
            addToCartBottomBar(size),
          ],
        ),
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();

    path.lineTo(0, height - 70);
    path.quadraticBezierTo(width / 2, height, width, height - 70);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DotsForImageIndex extends StatelessWidget {
  DotsForImageIndex({@required this.isSecondImageShown});

  final bool isSecondImageShown;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isSecondImageShown ? Color(0xffCDB7CA) : Color(0xff2B1327)),
        ),
        SizedBox(width: 3),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  !isSecondImageShown ? Color(0xffCDB7CA) : Color(0xff2B1327)),
        ),
      ],
    );
  }
}
