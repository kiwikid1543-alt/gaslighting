import 'package:flutter_gaslighting/data/model/weather_model.dart';
import 'package:flutter_gaslighting/data/repository/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRepositoryImpl weatherRepository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRepository = WeatherRepositoryImpl(mockHttpClient);
    registerFallbackValue(Uri());
  });

  group('WeatherRepository', () {
    const latitude = 37.57;
    const longitude = 126.98;
    final successBody = '''
      {
        "latitude": 37.57,
        "longitude": 126.98,
        "generationtime_ms": 1.2,
        "utc_offset_seconds": 32400,
        "timezone": "Asia/Seoul",
        "timezone_abbreviation": "KST",
        "elevation": 38.0,
        "current_weather": {
          "temperature": 25.0,
          "windspeed": 5.0,
          "winddirection": 180.0,
          "weathercode": 1,
          "is_day": 1,
          "time": "2023-10-10T12:00"
        }
      }
    ''';

    test('fetchWeather returns WeatherResponse on 200 OK', () async {
      when(
        () => mockHttpClient.get(any()),
      ).thenAnswer((_) async => http.Response(successBody, 200));

      final result = await weatherRepository.fetchWeather(
        latitude: latitude,
        longitude: longitude,
      );

      expect(result, isA<WeatherResponse>());
      expect(result.latitude, latitude);
      verify(() => mockHttpClient.get(any())).called(1);
    });

    test('fetchWeather throws Exception on non-200 response', () async {
      when(
        () => mockHttpClient.get(any()),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
        () => weatherRepository.fetchWeather(
          latitude: latitude,
          longitude: longitude,
        ),
        throwsException,
      );
    });
  });
}
