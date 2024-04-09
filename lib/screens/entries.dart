import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:jotmob/dummy_data/dummy_journal.dart';
import 'package:justjot/screens/journal.dart';
import 'package:justjot/widgets/gradient.dart';
import 'package:justjot/widgets/journal_entry.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({super.key});

  @override
  State<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  var journalBox = Hive.box('journal');

  @override
  Widget build(BuildContext context) {
    final int journal_index = ModalRoute.of(context)!.settings.arguments as int;

    // var journal = DummyEntry();
    // var journalEntries = journal.dummyEntry;

    var journalEntries = journalBox.get(journal_index);
    var journalDate = journalEntries.keys.toList()[0];

    void deleteEntry(int index) async {
      if (journalEntries[journalDate].length == 1) {
        journalBox.deleteAt(journal_index);
        Navigator.pushReplacementNamed(context, '/journal');
      } else {
        journalBox.get(journal_index)[journalDate].removeAt(index);
        journalBox.put(journal_index, journalBox.get(journal_index));
        setState(() {
          journalEntries = journalBox.get(journal_index);
        });
      }

      // print(journalEntries);
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //turn to sliver app bar
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const JournalScreen(),
                      maintainState: false));
            },
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Entries',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Aclonica', fontSize: 30.0),
          ),
        ),
        body: GradientBackground(
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: journalBox.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          journalDate.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Aclonica'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: journalEntries[journalDate].length!,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (BuildContext context, int index) {
                                  return JournalEntry(
                                      callback: () {
                                        deleteEntry(index);
                                      },
                                      index: index,
                                      date: journalDate.toString(),
                                      time: Hive.box('journal')
                                              .values
                                              .toList()[journal_index]
                                          [journalDate][index]['time'],
                                      entry: Hive.box('journal')
                                              .values
                                              .toList()[journal_index]
                                          [journalDate][index]['entry']);
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
        ));
  }
}
