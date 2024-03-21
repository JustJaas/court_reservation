import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBConnection {
  Database? database;

  Future<String> get fullPath async {
    const name = 'booking.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      // onCreate: create,
      singleInstance: true,
    );

    return database;
  }

  // Future<void> create(Database database, int version) async {
  //   await BookingDB().createTable(database);
  // }
}
