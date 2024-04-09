import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class EntryModel {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String entry;

  const EntryModel(
      {required this.date, required this.title, required this.entry});
}
