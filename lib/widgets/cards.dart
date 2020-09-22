import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductCard extends StatefulWidget {
  final String imgUrl;

  ProductCard({Key key, this.imgUrl}) : super();

  @override
  _ProductCardState createState() => _ProductCardState(imgUrl);
}

class _ProductCardState extends State<ProductCard> {
  _ProductCardState(imgUrl);
  bool isHeartPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 190,
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xffFFC4CA).withOpacity(0.4),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          new BoxShadow(
              color: Colors.pink[700].withOpacity(.1),
              blurRadius: 8,
              spreadRadius: 1.0,
              offset: Offset(0.0, 4.0))
        ],
      ),
      child: Container(
        height: 100,
        width: 180,
//        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/textureBG.png"),
          ),
          color: Color(0xffFFC4CA).withOpacity(0.5),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Container(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  top: 20,
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      (widget.imgUrl),
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: isHeartPressed
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isHeartPressed = !isHeartPressed;
                            });
                            print(isHeartPressed);
                          },
                          icon: Icon(
                            FontAwesomeIcons.solidHeart,
                            size: 21,
                            color: Colors.pink[600],
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              isHeartPressed = !isHeartPressed;
                            });
                          },
                          icon: Icon(
                            FontAwesomeIcons.heart,
                            size: 21,
                            color: Colors.pink[400],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
