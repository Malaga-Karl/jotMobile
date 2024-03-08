import 'package:flutter/material.dart';
import 'package:jotmob/screens/home.dart';
import 'screens/splash.dart';

void main() {
  runApp(MaterialApp(
    title: 'JustJot',
    initialRoute: '/splash',
    routes: {
      '/splash': (context) => const SplashScreen(),
      '/home': (context) => const HomeScreen(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
