import 'package:flutter/material.dart';
import 'package:uas_mobile/pages/splash_page.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Gilroy',
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}