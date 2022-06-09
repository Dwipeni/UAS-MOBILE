import 'package:uas_mobile/src/app.dart';
import 'package:flutter/material.dart';
import 'package:uas_mobile/pages/splash_page.dart';

void main() => runApp(App());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Gilroy',
      ),
      home: SplashPage(),
    );
  }
}