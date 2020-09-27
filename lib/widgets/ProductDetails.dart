import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_vide/models/ClothingSizeNotifier.dart';
import 'package:the_vide/models/Product.dart';
import 'package:the_vide/widgets/AddToCartWidget.dart';
import 'package:the_vide/widgets/ClothingSizeWidget.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  static final Color purchaseBarPrimaryColor = Color(0xffC7AEC3);
  static final Color productDetailAccentColor = Color(0xff2B1327);
  static const String EMPTY_SIZE_CHOICE = "empty";
  static const String TOO_MANY_SIZE_CHOICES = "too_many";

  Color get purchaseBarColor => purchaseBarPrimaryColor;

  Color get productDetailAccent => productDetailAccentColor;

  ProductDetails(this.product);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int numberOfProducts = 1;

  _ProductDetailsState();

  int verifySelectedSingleChoice(List<bool> listBoolean) {
    int selectedSizesCount = 0;
    if (listBoolean[0]) selectedSizesCount++;
    if (listBoolean[1]) selectedSizesCount++;
    if (listBoolean[2]) selectedSizesCount++;
    if (listBoolean[3]) selectedSizesCount++;

    return selectedSizesCount;
  }

  String getSelectedSize(ClothingSizeNotifier listBoolean) {
    if (verifySelectedSingleChoice(listBoolean.getIsSelected) == 1) {
      if (listBoolean.getIsSelected[0]) {
        for (int i = 0; i < 4; i++) {
          if (i != 0) {
            listBoolean.getIsSelected[i] = false;
          }
        }
        return "S";
      }

      if (listBoolean.getIsSelected[1]) {
        for (int i = 0; i < 4; i++) {
          if (i != 1) {
            listBoolean.getIsSelected[i] = false;
          }
        }
        return "M";
      }

      if (listBoolean.getIsSelected[2]) {
        for (int i = 0; i < 4; i++) {
          if (i != 2) {
            listBoolean.getIsSelected[i] = false;
          }
        }
        return "L";
      }

      if (listBoolean.getIsSelected[3]) {
        for (int i = 0; i < 4; i++) {
          if (i != 3) {
            listBoolean.getIsSelected[i] = false;
            print(listBoolean.getIsSelected[i].toString());
          }
        }
        return "XL";
      }
    } else if (verifySelectedSingleChoice(listBoolean.getIsSelected) == 0) {
      return ProductDetails.EMPTY_SIZE_CHOICE;
    } else {
      return ProductDetails.TOO_MANY_SIZE_CHOICES;
    }
  }

  bool _isSecondImageShown = false;

  bool get getIsSecondImageShown => _isSecondImageShown;

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
                GestureDetector(
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
                        ? Image.asset(widget.product.imgUrl[1])
                        : Image.asset(widget.product.imgUrl[2]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 60),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_upward,
                        size: 20,
                        color: widget.productDetailAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            DotsForImageIndex(isSecondImageShown: _isSecondImageShown),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                        color: Color(0xff55254F),
                        decoration: TextDecoration.none,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0),
                  ),
                  Text(
                    widget.product.price.toString() +
                        " " +
                        widget.product.currency,
                    style: TextStyle(
                        color: Color(0xffB17CAA),
                        decoration: TextDecoration.none,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0),
                  ),
                ],
              ),
            ),
            Consumer<ClothingSizeNotifier>(
              builder: (context, isSelected, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClothingSizeWidget("S", isSelected),
                    ClothingSizeWidget("M", isSelected),
                    ClothingSizeWidget("L", isSelected),
                    ClothingSizeWidget("XL", isSelected),
                  ],
                );
              },
            ),
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
            Container(
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
                      if (numberOfProducts > 1)
                        setState(() {
                          numberOfProducts--;
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
                      numberOfProducts.toString(),
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
                        numberOfProducts++;
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
                  Consumer<ClothingSizeNotifier>(
                      builder: (context, listOfBooleans, child) {
                    return AddToCartWidget(widget.product, numberOfProducts,
                        getSelectedSize(listOfBooleans));
                  }),
                ],
              ),
            )
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
