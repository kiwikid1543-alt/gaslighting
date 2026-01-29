import 'package:flutter_gaslighting/data/model/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeatherModel', () {
    final weatherJson = {
      'latitude': 37.57,
      'longitude': 126.98,
      'generationtime_ms': 1.2,
      'utc_offset_seconds': 32400,
      'timezone': 'Asia/Seoul',
      'timezone_abbreviation': 'KST',
      'elevation': 38.0,
      'current_weather': {
        'temperature': 25.0,
        'windspeed': 5.0,
        'winddirection': 180.0,
        'weathercode': 1,
        'is_day': 1,
        'time': '2023-10-10T12:00',
      },
    };

    test('fromJson creates a valid WeatherResponse object', () {
      final weatherResponse = WeatherResponse.fromJson(weatherJson);

      expect(weatherResponse.latitude, 37.57);
      expect(weatherResponse.longitude, 126.98);
      expect(weatherResponse.currentWeather.temperature, 25.0);
      expect(weatherResponse.currentWeather.time, '2023-10-10T12:00');
    });

    test('toJson returns a valid JSON map', () {
      final weatherResponse = WeatherResponse(
        latitude: 37.57,
        longitude: 126.98,
        generationtimeMs: 1.2,
        utcOffsetSeconds: 32400,
        timezone: 'Asia/Seoul',
        timezoneAbbreviation: 'KST',
        elevation: 38.0,
        currentWeather: CurrentWeather(
          temperature: 25.0,
          windspeed: 5.0,
          winddirection: 180.0,
          weathercode: 1,
          isDay: 1,
          time: '2023-10-10T12:00',
        ),
      );

      final json = weatherResponse.toJson();

      expect(json, weatherJson);
    });
  });
}
