import 'package:flutter/material.dart';

class ClothingSizeWidget extends StatefulWidget {
  final String clothingSize;
  final _isPressed;
  ClothingSizeWidget(this.clothingSize, this._isPressed);
  @override
  _ClothingSizeWidgetState createState() => _ClothingSizeWidgetState();
}

class _ClothingSizeWidgetState extends State<ClothingSizeWidget> {
  _ClothingSizeWidgetState();

  @override
  Widget build(BuildContext context) {
//    int i;
//    switch (widget.clothingSize) {
//      case "S":
//        i = 0;
//        break;
//      case "M":
//        i = 1;
//        break;
//      case "L":
//        i = 2;
//        break;
//      case "XL":
//        i = 3;
//        break;
//    }
//    bool _isPressed = widget._clothingSizeNotifier.getIsSelected[i];
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Center(
        child: Text(
          widget.clothingSize,
          style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Nunito',
              fontSize: size.height / 10 / 3.5,
              fontWeight: FontWeight.w500,
              color: widget._isPressed ? Colors.white : Colors.pink[600]),
        ),
      ),
      height: size.height / 21,
      width: size.width / 11,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(11)),
        color: widget._isPressed ? Color(0xff2B1327) : Colors.transparent,
        border: Border.all(
          color: widget._isPressed
              ? Colors.transparent
              : Colors.pink[300].withOpacity(1),
        ),
      ),
    );
  }
}
