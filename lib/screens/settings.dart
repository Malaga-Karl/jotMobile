import 'package:flutter/material.dart';
import 'package:justjot/widgets/gradient.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: GradientBackground(
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  print('hello');
                },
                child: const ListTile(
                  title: Text(
                    'PIN',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  print('hello');
                },
                child: const ListTile(
                  title: Text('Backup & Restore',
                      style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
