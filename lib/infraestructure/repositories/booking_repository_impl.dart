import 'package:court_reservation/domain/datasources/booking_datasource.dart';
import 'package:court_reservation/domain/entities/booking.dart';
import 'package:court_reservation/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl extends BookingRepository {
  final BookingDatasource datasource;
  BookingRepositoryImpl(this.datasource);

  @override
  Future<int> create({
    required String name,
    required String date,
    required String weather,
    required String urlIcon,
    required String courtId,
  }) {
    return datasource.create(
        name: name,
        date: date,
        weather: weather,
        urlIcon: urlIcon,
        courtId: courtId);
  }

  @override
  Future<void> createTable() {
    return datasource.createTable();
  }

  @override
  Future<void> delete(int id) {
    return datasource.delete(id);
  }

  @override
  Future<List<Booking>> fetchAll() {
    return datasource.fetchAll();
  }

  @override
  Future<int> fetchByCourt(String courtId, String date) {
    return datasource.fetchByCourt(courtId, date);
  }
}
