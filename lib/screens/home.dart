import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:justjot/widgets/gradient.dart';

Future<void> initialize() async {
  await Hive.openBox('journal');
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 1;
  SnackBar sendFail = const SnackBar(
    duration: Duration(seconds: 1),
    content: Text("Long press to save"),
    backgroundColor: Colors.red,
  );

  SnackBar sendSuccess = const SnackBar(
    duration: Duration(seconds: 1),
    content: Text("Jot saved!"),
    backgroundColor: Colors.green,
  );

  SnackBar emptyString = const SnackBar(
    duration: Duration(seconds: 1),
    content: Text("Can't jot empty entry"),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
    // String formattedDate = "June 18, 2024";
    TextEditingController controller = TextEditingController();
    initialize();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.lock_outlined,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/journal');
            },
          ),
        ],
      ),
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
                      Image.asset(
                        'assets/images/wordlogo.png',
                        width: 150,
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'Aclonica'),
                        softWrap: true,
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
                    onPressed: () {
                      print(formattedTime);
                      if (_counter < 3) {
                        _counter++;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(sendFail);
                        _counter = 1;
                      }
                      // Hive.box('journal').clear();
                    },
                    onLongPress: () {
                      var index = Hive.box('journal').keys.toList().isNotEmpty
                          ? Hive.box('journal').keys.toList().length
                          : 0;
                      // var index = 1;
                      Hive.openBox('journal');
                      if (controller.text.isNotEmpty) {
                        if ((Hive.box('journal').keys.toList().isNotEmpty &&
                                Hive.box('journal')
                                        .values
                                        .last
                                        .keys
                                        .toList()[0] !=
                                    formattedDate) ||
                            Hive.box('journal').keys.toList().isEmpty) {
                          setState(() {
                            Hive.box('journal').put(index, {
                              formattedDate: [
                                {
                                  'time': formattedTime.toString(),
                                  'entry': controller.text
                                }
                              ]
                            });
                          });
                        } else {
                          setState(() {
                            Hive.box('journal')
                                .get(index - 1)[formattedDate]
                                .add({
                              'time': formattedTime.toString(),
                              'entry': controller.text,
                            });
                            Hive.box('journal').put(
                                index - 1, Hive.box('journal').get(index - 1));
                          });
                        }
                        // print(Hive.box('journal').get(formattedDate));
                        ScaffoldMessenger.of(context).showSnackBar(sendSuccess);
                        controller.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(emptyString);
                      }
                    },
                    child: const Text(
                      'Jot',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
