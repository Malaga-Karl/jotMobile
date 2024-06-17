import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:justjot/screens/home.dart';
import 'package:justjot/widgets/gradient.dart';
// import 'package:justjot/dummy_data/dummy_journal.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('journal'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return const JournalBodyScreen();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class JournalBodyScreen extends StatelessWidget {
  const JournalBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var journal = DummyEntry();
    // var journalEntries = journal.dummyEntry;
    // List journalDates = journalEntries.keys.toList();
    final journalBox = Hive.box('journal');
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // turn to sliver app bar
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                  maintainState: true),
            );
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Journal',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Aclonica', fontSize: 30.0),
            ),
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.backup_outlined),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              color: Colors.white,
            )
          ],
        ),
      ),
      body: GradientBackground(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: journalBox.isNotEmpty
                ? Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: journalBox.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                    journalBox.values
                                        .toList()[index]
                                        .keys
                                        .toList()[0]
                                        .toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                      '${journalBox.values.toList()[index][journalBox.values.toList()[index].keys.toList()[0]].length} Entries'),
                                  leading: const Icon(Icons.book),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.arrow_forward_ios),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/entries',
                                          arguments: index);
                                    },
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                      'No entries yet',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Aclonica'),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
