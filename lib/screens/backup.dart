import 'package:flutter/material.dart';
import 'package:justjot/widgets/gradient.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Latest Entry: April 14, 2024",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.backup_outlined,
                  color: Colors.black,
                ),
                label: const Text(
                  "Backup",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              const SizedBox(height: 16),
              const Text("No backup found",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: null,
                icon: const Icon(
                  Icons.restore_outlined,
                  color: Colors.black,
                ),
                label: const Text(
                  "Restore",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
