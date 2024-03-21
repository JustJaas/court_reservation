import 'package:court_reservation/domain/entities/weather_response.dart';

abstract class WeatherDatasource {
  Future<WeatherResponse> getData(String courtId);
}
