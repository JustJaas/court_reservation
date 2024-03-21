import 'package:court_reservation/domain/datasources/booking_datasource.dart';
import 'package:court_reservation/domain/entities/booking.dart';
import 'package:court_reservation/infraestructure/helpers/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class BookingDBDatasource extends BookingDatasource {
  late Future<Database> database;
  final tableName = 'bookings';

  BookingDBDatasource() {
    database = startDB();
  }

  Future<Database> startDB() async {
    return await DBConnection().initialize();
  }

  @override
  Future<int> create({
    required String name,
    required String date,
    required String weather,
    required String urlIcon,
    required String courtId,
  }) async {
    final db = await database;
    return await db.rawInsert(
      '''INSERT INTO $tableName (name, date, weather, urlIcon, courtId) VALUES (?, ?, ?, ?, ?)''',
      [name, date, weather, urlIcon, courtId],
    );
  }

  @override
  Future<void> createTable() async {
    final db = await database;
    await db.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "date" TEXT NOT NULL,
      "weather" TEXT NOT NULL,
      "urlIcon" TEXT NOT NULL,
      "courtId" TEXT NOT NULL,
      PRIMARY KEY ("id" AUTOINCREMENT)
    );""");
  }

  @override
  Future<void> delete(int id) async {
    final db = await database;
    await db.rawDelete('''DELETE FROM $tableName WHERE id = ? ''', [id]);
  }

  @override
  Future<List<Booking>> fetchAll() async {
    final db = await database;
    final bookings = await db.rawQuery(
      '''SELECT * from $tableName ORDER BY date ASC''',
    );
    return bookings
        .map((booking) => Booking.fromSqliteDatabase(booking))
        .toList();
  }

  @override
  Future<int> fetchByCourt(String courtId, String date) async {
    final db = await database;

    final booking = await db.rawQuery(
        ''' SELECT COUNT(*) as count FROM $tableName WHERE courtId = ? AND date = ? ''',
        [courtId, date]);
    int count = Sqflite.firstIntValue(booking) ?? 0;
    return count;
  }
}
