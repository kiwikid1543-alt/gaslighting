import 'package:flutter_gaslighting/domain/entity/weather.dart';
import 'package:flutter_gaslighting/domain/repository/weather_repository.dart';

class FetchWeatherUseCase {
  FetchWeatherUseCase(this.weatherRepository);
  final WeatherRepository weatherRepository;

  Future<Weather> execute(double latitude, double longitude) async {
    return weatherRepository.fetchWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
