import 'package:flutter/material.dart';
import 'package:jotmob/widgets/gradient.dart';
import 'package:jotmob/dummy_data/dummy_journal.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var journal = DummyEntry();
    var journalEntries = journal.dummyEntry;
    List journalDates = journalEntries.keys.toList();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // turn to sliver app bar
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
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: journalDates.length,
                        reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              journalDates[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                                '${journalEntries[journalDates[index]]?.length} Entries'),
                            leading: const Icon(Icons.book),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                Navigator.pushNamed(context, '/entries',
                                    arguments: journalDates[index]);
                              },
                            ),
                          );
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
