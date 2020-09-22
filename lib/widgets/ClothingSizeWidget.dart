import 'package:flutter/material.dart';

class ClothingSizeWidget extends StatefulWidget {
  final String clothingSize;
  ClothingSizeWidget(this.clothingSize);
  @override
  _ClothingSizeWidgetState createState() =>
      _ClothingSizeWidgetState(clothingSize);
}

class _ClothingSizeWidgetState extends State<ClothingSizeWidget> {
  _ClothingSizeWidgetState(clothingSize);
  @override
  Widget build(BuildContext context) {
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
              color: Colors.pink[600]),
        ),
      ),
      height: size.height / 21,
      width: size.width / 11,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(11)),
        border: Border.all(
          color: Colors.pink[300].withOpacity(1),
        ),
      ),
    );
  }
}
