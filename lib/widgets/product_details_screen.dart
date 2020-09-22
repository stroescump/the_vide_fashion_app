import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_vide/models/Product.dart';
import 'package:the_vide/widgets/AddToCartWidget.dart';
import 'package:the_vide/widgets/ClothingSizeWidget.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  ProductDetails(this.product);

  @override
  _ProductDetailsState createState() => _ProductDetailsState(product);
}

class _ProductDetailsState extends State<ProductDetails> {
  int numberOfProducts = 1;
  _ProductDetailsState(product);

  bool _isSecondImageShown = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: Color(0xffffdeeb)),
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
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isSecondImageShown
                        ? Color(0xffCDB7CA)
                        : Color(0xff2B1327)),
              ),
              SizedBox(width: 3),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: !_isSecondImageShown
                        ? Color(0xffCDB7CA)
                        : Color(0xff2B1327)),
              ),
            ],
          ),
          Column(
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
                widget.product.price.toString() + " " + widget.product.currency,
                style: TextStyle(
                    color: Color(0xffB17CAA),
                    decoration: TextDecoration.none,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClothingSizeWidget("S"),
              ClothingSizeWidget("M"),
              ClothingSizeWidget("L"),
              ClothingSizeWidget("XL"),
            ],
          ),
//          Expanded(
//            child:
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            width: size.width * 0.80,
            height: size.height / 8,
            decoration: BoxDecoration(
              color: Color(0xffBA6889),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Text(
                widget.product.description,
                style: TextStyle(
                    color: Color(0xffffffff),
                    decoration: TextDecoration.none,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0),
              ),
            ),
          ),
//          ),
          //TODO: THIS IS SO TIGANIE, PUSHED THE PURCHASE BAR DOWN USING THIS...
          SizedBox(height: 25),
          //TODO: PURCHASE BAR
          Container(
//            alignment: Alignment(-0.5,-0.5),
            height: size.height / 10,
            decoration: BoxDecoration(
              color: Color(0xffF5F0F2),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                      color: Color(0xff2B1327).withOpacity(.93),
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
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    numberOfProducts.toString(),
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color(0xff2B1327),
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
                      color: Color(0xff2B1327).withOpacity(.93),
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
                AddToCartWidget(),
              ],
            ),
          )
        ],
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
