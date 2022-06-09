import 'dart:ui';
import 'package:uas_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:uas_mobile/core/color.dart';
//import 'package:flower_app/widgets/bottom_nav.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 30),
          const Text(
            'Selamat datang di QueueApp',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.0,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Aplikasi Antrean Online Vaksinasi COVID-19 Desa Halu',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: grey,
              fontSize: 15,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 200,
            width: 300,
            child: Image.asset('assets/images/logo.jpg'),
          ),
          const SizedBox(height: 25),
          const Text(
            'Copyright 2022',
            style: TextStyle(
              color: grey,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => HomePage()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                "Masuk",
                style: TextStyle(
                  color: white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}