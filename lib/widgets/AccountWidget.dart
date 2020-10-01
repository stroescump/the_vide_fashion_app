import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:the_vide/helpers/auth.dart';

import 'home.dart';

class AccountWidget extends StatefulWidget {
  final AuthService authService = AuthService();
  final TextStyle accountTextStyleTitle = TextStyle(
      color: Colors.white,
      fontFamily: 'Nunito',
      fontSize: 70,
      fontWeight: FontWeight.w600);
  final TextStyle accountTextStyleBodyBold = TextStyle(
      color: Colors.white,
      shadows: [
        Shadow(
            blurRadius: 8,
            color: Colors.black87.withAlpha(25),
            offset: Offset(0, 5))
      ],
      fontFamily: 'Nunito',
      fontSize: 25,
      fontWeight: FontWeight.w900);

  final TextStyle accountTextStyleBody = TextStyle(
      color: Colors.black87,
      fontFamily: 'Nunito',
      fontSize: 20,
      fontWeight: FontWeight.w900);

  @override
  _AccountWidgetState createState() => _AccountWidgetState(authService);
}

class _AccountWidgetState extends State<AccountWidget> {
  User _user;
  bool _isLoggedIn = false;

  _AccountWidgetState(authService);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double aspectRatio = size.height / size.width;
    print(aspectRatio);
    print(widget.authService);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: aspectRatio <= 1.69
                  ? AssetImage("assets/images/login_bg_newspaper_16_10.png")
                  : AssetImage("assets/images/login_bg_newspaper.png"),
              fit: BoxFit.fitHeight),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/thevide_title_artwork.png",
                scale: 3,
              ),
            ),
            _isLoggedIn
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        "Welcome back,",
                        style: widget.accountTextStyleBodyBold,
                      ),
                      Text(
                        _user.displayName,
                        style: widget.accountTextStyleBodyBold,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.white70.withAlpha(150),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(_user.photoURL),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          width: size.width * 0.55,
                          decoration: BoxDecoration(
                              color: Colors.white.withAlpha(180),
                              borderRadius: BorderRadius.circular(40)),
                          child: FlatButton(
                            padding: EdgeInsets.all(11),
                            splashColor: Colors.black87,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ));
                            },
                            child: Text(
                              "Go shopping",
                              style: widget.accountTextStyleBody,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Container(
                    child: Text(""),
                  ),
            Spacer(),
            !_isLoggedIn
                ? Container(
                    margin: EdgeInsets.only(bottom: 100),
                    child: Column(
                      children: [
                        SignInButton(
                          size,
                          Buttons.Email,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          mini: false,
                          onPressed: () {},
                        ),
                        SignInButton(
                          size,
                          Buttons.Google,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          mini: false,
                          onPressed: () =>
                              widget.authService.googleSignIn().then((user) {
                            setState(() {
                              _user = user;
                              _isLoggedIn = true;
                            });
                          }),
                        ),
                        SignInButton(
                          size,
                          Buttons.FacebookNew,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          mini: false,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
