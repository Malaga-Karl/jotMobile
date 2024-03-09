import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground(this.widget, {super.key});

  GradientBackground.image({super.key})
      : widget = Animate(
            delay: const Duration(seconds: 1),
            effects: const [FadeEffect(), SlideEffect()],
            child: Image.asset('assets/images/jotlogo.png',
                width: 200, height: 200));

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0B0A), Color(0xFF373736)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: widget,
        ));
  }
}
