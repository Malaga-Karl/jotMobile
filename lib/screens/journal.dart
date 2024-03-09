import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jotmob/widgets/gradient.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradientBackground(
        SafeArea(
          child: Column(
            children: [
              Text('Journal'),
            ],
          ),
        ),
      ),
    );
  }
}
