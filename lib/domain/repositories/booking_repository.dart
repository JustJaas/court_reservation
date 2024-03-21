import 'package:court_reservation/domain/entities/booking.dart';

abstract class BookingRepository {
  Future<void> createTable();

  Future<int> create({
    required String name,
    required String date,
    required String weather,
    required String urlIcon,
    required String courtId,
  });

  Future<List<Booking>> fetchAll();

  Future<int> fetchByCourt(String courtId, String date);

  Future<void> delete(int id);
}
