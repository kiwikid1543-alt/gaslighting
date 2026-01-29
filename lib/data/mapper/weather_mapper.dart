import 'package:flutter_gaslighting/data/dto/weather_dto.dart';
import 'package:flutter_gaslighting/domain/entity/weather.dart';

extension WeatherMapper on WeatherDto {
  Weather toEntity() {
    return Weather(
      latitude: latitude,
      longitude: longitude,
      timezone: timezone,
      elevation: elevation,
      timezoneAbbreviation: timezoneAbbreviation,
      currentWeather: CurrentWeather(
        temperature: currentWeather.temperature,
        windspeed: currentWeather.windspeed,
        winddirection: currentWeather.winddirection,
        weathercode: currentWeather.weathercode,
        isDay: currentWeather.isDay,
        time: currentWeather.time,
      ),
    );
  }
}
