import 'package:flutter_gaslighting/data/data_source/weather_data_source.dart';
import 'package:flutter_gaslighting/data/mapper/weather_mapper.dart';
import 'package:flutter_gaslighting/domain/entity/weather.dart';
import 'package:flutter_gaslighting/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this.weatherDataSource);
  final WeatherDataSource weatherDataSource;

  @override
  Future<Weather> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final result = await weatherDataSource.fetchWeather(latitude, longitude);
    return result.toEntity();
  }
}
