import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jotmob/widgets/gradient.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
    TextEditingController controller = TextEditingController();

    return Scaffold(
      body: GradientBackground(
        SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'JustJot',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontFamily: 'Aclonica'),
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'Aclonica'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: controller,
                    cursorColor: const Color.fromARGB(255, 110, 109, 109),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 120, 117, 117)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      onLongPress: () {
                        controller.clear();
                      },
                      child: const Text(
                        'Jot',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
