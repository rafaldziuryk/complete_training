import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Drift table definition
class Counters extends Table {
  IntColumn get id => integer().autoIncrement().unique()();
  IntColumn get value => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Database class
@DriftDatabase(tables: [Counters])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Get all counters
  Future<List<Counter>> getAllCounters() async {
    return await select(counters).get();
  }

  // Get counter by ID
  Future<Counter?> getCounter(int id) async {
    return await (select(counters)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Insert new counter
  Future<int> insertCounter(int value) async {
    return await into(counters).insert(CountersCompanion.insert(value: value));
  }

  // Update counter
  Future<bool> updateCounter(int id, int value) async {
    return await (update(counters)..where((tbl) => tbl.id.equals(id)))
        .write(CountersCompanion(value: Value(value))) > 0;
  }

  // Delete counter
  Future<bool> deleteCounter(int id) async {
    final deleted = await (delete(counters)..where((tbl) => tbl.id.equals(id))).go();
    return deleted > 0;
  }

  // Get counters stream for reactive UI
  Stream<List<Counter>> watchCounters() {
    return select(counters).watch();
  }

  // Get total count
  Future<int> getTotalCount() async {
    final allCounters = await getAllCounters();
    return allCounters.fold<int>(0, (sum, counter) => sum + counter.value);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'drift_demo.db'));
    return NativeDatabase.createInBackground(file);
  });
}