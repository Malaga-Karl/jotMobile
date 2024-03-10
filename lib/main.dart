import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jotmob/screens/entries.dart';
import 'package:jotmob/screens/home.dart';
import 'package:jotmob/screens/journal.dart';
import 'screens/splash.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JustJot',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/journal': (context) => const JournalScreen(),
        '/entries': (context) => const EntriesScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
