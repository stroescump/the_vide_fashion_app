import 'package:flutter/material.dart';

class TopMenu extends StatefulWidget {
  @override
  _TopMenuState createState() => _TopMenuState();
}

class _TopMenuState extends State<TopMenu> {
  bool _isSearchBoxFocused = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.35,
      child: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/pineapple.jpg"),
                      fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.account_circle),
                  color: Colors.pink[800],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.pink[800],
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 20),
            child: Text("THE ViDE",
                style: TextStyle(
                    color: Color(0xffFAFAFA).withOpacity(0.90),
                    fontSize: 45.0,
                    fontFamily: 'Averta',
                    fontWeight: FontWeight.w900)),
          ),
          Container(
            alignment: Alignment(0, 0.85),
            child: Opacity(
              opacity: _isSearchBoxFocused ? 1.0 : 0.7,
              child: Container(
                width: size.width * 0.82,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.75 - 50,
                      padding: EdgeInsets.only(left: 15),
                      child: TextField(
                        onTap: () {
                          setState(() {
                            _isSearchBoxFocused = !_isSearchBoxFocused;
                          });
                        },
                        onEditingComplete: () {
                          setState(() {
                            _isSearchBoxFocused = false;
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
//                        autofocus: true,
                        textAlign: TextAlign.left,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            hintText: "Search here..."),
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                      color: Colors.white,
                      iconSize: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
