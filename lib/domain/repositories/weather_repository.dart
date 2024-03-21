import 'package:court_reservation/domain/entities/weather_response.dart';

abstract class WeatherRepository {
  Future<WeatherResponse> getData(String courtId);
}
