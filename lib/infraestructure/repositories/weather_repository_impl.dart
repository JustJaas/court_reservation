import 'package:court_reservation/domain/datasources/weather_datasource.dart';
import 'package:court_reservation/domain/entities/weather_response.dart';
import 'package:court_reservation/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDatasource datasource;
  WeatherRepositoryImpl(this.datasource);

  @override
  Future<WeatherResponse> getData(String courtId) {
    return datasource.getData(courtId);
  }
}
