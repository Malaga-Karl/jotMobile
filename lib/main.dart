import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:justjot/screens/entries.dart';
import 'package:justjot/screens/home.dart';
import 'package:justjot/screens/journal.dart';
import 'screens/splash.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.initFlutter(appDocumentDirectory.path);

  runApp(const MyApp());
  // Close the box when done
  // Make sure to close the Hive instance too
  await Hive.close();
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
