import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_vide/helpers/SharedPreferences.dart';
import 'package:the_vide/models/CartNotifier.dart';

import 'widgets/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await sharedPrefs.init();
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
