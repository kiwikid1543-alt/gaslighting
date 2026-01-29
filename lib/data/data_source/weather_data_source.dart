import 'package:flutter_gaslighting/data/dto/weather_dto.dart';

abstract interface class WeatherDataSource {
  Future<WeatherDto> fetchWeather(double latitude, double longitude);
}
