import 'package:flutter/material.dart';
import 'package:cinemaapp/Login/login_page.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    hideScreen();
    return MaterialApp(
      title: 'Zuhot Cinema',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }

  void hideScreen() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      FlutterSplashScreen.hide();
    });
  }
}
