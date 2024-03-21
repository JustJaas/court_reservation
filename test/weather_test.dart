import 'package:court_reservation/infraestructure/datasources/weather_api_datasource.dart';
import 'package:court_reservation/infraestructure/repositories/weather_repository_impl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  await dotenv.load();

  final weatherRepositoryProvider =
      WeatherRepositoryImpl(WeatherAPIDatasource());

  group('Get data from API', () {
    test("Data weather Court A", () async {
      final response = await weatherRepositoryProvider.getData("A");
      expect(response, isNotNull);
    });

    test("Data weather Court B", () async {
      final response = await weatherRepositoryProvider.getData("B");
      expect(response, isNotNull);
    });

    test("Data weather Court C", () async {
      final response = await weatherRepositoryProvider.getData("C");
      expect(response, isNotNull);
    });
  });
}
