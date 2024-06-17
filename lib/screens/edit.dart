import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:justjot/widgets/gradient.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(
      {super.key,
      required this.index,
      required this.date,
      required this.journ_index});

  final String date;
  final int index;
  final int journ_index;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(
        text: Hive.box('journal').values.toList()[widget.journ_index]
            [widget.date][widget.index]['entry']);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (controller.text !=
                Hive.box('journal').values.toList()[widget.journ_index]
                    [widget.date][widget.index]['entry']) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Discard Changes?'),
                    content:
                        const Text('Are you sure you want to discard changes?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Row(
          children: [
            Text(
              'Edit Entry',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Aclonica', fontSize: 30.0),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "JustEdit",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Aclonica',
                        fontSize: 32,
                      ),
                      softWrap: true,
                    ),
                    Text(
                      widget.date,
                      textAlign: TextAlign.start,
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
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {},
                  onLongPress: () {
                    setState(() {
                      Hive.box('journal').values.toList()[widget.journ_index]
                              [widget.date][widget.index]['entry'] =
                          controller.text;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
