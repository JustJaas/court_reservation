import 'package:sqflite/sqlite_api.dart';

abstract class CourtRepository {
  Future<void> createTable(Database database);

  Future<int> create({
    required String name,
  });
}
