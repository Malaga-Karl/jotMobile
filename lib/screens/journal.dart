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
                builder: (context) => HomeScreen(),
                maintainState: true),);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Journal',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Aclonica', fontSize: 30.0),
            ),
            Icon(
              Icons.lock_open_outlined,
              color: Colors.white,
              size: 30,
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
                              itemCount: journalBox.length,
                              reverse: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                    journalBox.keys.toList()[index],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                      '${journalBox.get(journalBox.keys.toList()[index]).length} Entries'),
                                  leading: const Icon(Icons.book),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.arrow_forward_ios),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/entries',
                                          arguments:
                                              journalBox.keys.toList()[index]);
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
