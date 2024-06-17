import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:justjot/dummy_data/dummy_journal.dart';
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
  bool isReverse = false;

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  icon: const Icon(
                    Icons.backup_outlined,
                    color: Colors.white,
                    size: 30,
                  )),
            )
          ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              journalDate.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Aclonica'),
                            ),
                            Switch(
                                activeColor: Colors.grey,
                                value: isReverse,
                                onChanged: (value) {
                                  setState(() {
                                    isReverse = value;
                                  });
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                reverse: isReverse,
                                shrinkWrap: true,
                                itemCount: journalEntries[journalDate].length!,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (BuildContext context, int index) {
                                  return JournalEntry(
                                      callback: () {
                                        deleteEntry(index);
                                      },
                                      journ_index: journal_index,
                                      // edit: () {
                                      //   editEntry(index);
                                      // },
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
