import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_vide/models/CartNotifier.dart';

import 'widgets/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Color(0xffffdeeb),
          scaffoldBackgroundColor: Color(0xffffdeeb),
          primarySwatch: Colors.pink,
        ),
        home: Home());
  }
}
