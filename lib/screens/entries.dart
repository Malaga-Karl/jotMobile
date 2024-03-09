import 'package:flutter/material.dart';
import 'package:jotmob/dummy_data/dummy_journal.dart';
import 'package:jotmob/widgets/gradient.dart';
import 'package:jotmob/widgets/journal_entry.dart';

class EntriesScreen extends StatelessWidget {
  const EntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String date = ModalRoute.of(context)!.settings.arguments as String;
    var journal = DummyEntry();
    var journalEntries = journal.dummyEntry;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //turn to sliver app bar
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Text(
                  date,
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
                        itemCount: journalEntries[date]!.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (BuildContext context, int index) {
                          return JournalEntry(
                              time: journalEntries[date]![index]['time']!,
                              entry: journalEntries[date]![index]['entry']!);
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
