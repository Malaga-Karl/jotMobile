import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jotmob/widgets/gradient.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });

    return Scaffold(
      body: GradientBackground.image(),
    );
  }
}
