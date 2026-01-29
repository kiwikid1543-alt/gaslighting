import 'package:flutter_gaslighting/data/model/weather_dto.dart';
import 'package:flutter_gaslighting/data/repository/weather_repository_impl.dart';
import 'package:flutter_gaslighting/presentaion/page/weather_screen_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockWeatherRepository mockWeatherRepository;

  final sampleWeatherResponse = WeatherResponse(
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

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
  });

  group('WeatherViewModel', () {
    test('initial build fetches weather data', () async {
      final container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
        ],
      );

      when(
        () => mockWeatherRepository.fetchWeather(
          latitude: 37.57,
          longitude: 126.98,
        ),
      ).thenAnswer((_) async => sampleWeatherResponse);

      final data = await container.read(weatherViewModelProvider.future);

      expect(data, sampleWeatherResponse);
      verify(
        () => mockWeatherRepository.fetchWeather(
          latitude: 37.57,
          longitude: 126.98,
        ),
      ).called(1);
    });

    test('fetchWeather triggers state reload', () async {
      final container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
        ],
      );

      when(
        () => mockWeatherRepository.fetchWeather(
          latitude: 37.57,
          longitude: 126.98,
        ),
      ).thenAnswer((_) async => sampleWeatherResponse);

      // Wait for initial build
      await container.read(weatherViewModelProvider.future);

      // Manual fetch
      await container.read(weatherViewModelProvider.notifier).fetchWeather();

      verify(
        () => mockWeatherRepository.fetchWeather(
          latitude: 37.57,
          longitude: 126.98,
        ),
      ).called(2);

      expect(
        container.read(weatherViewModelProvider).value,
        sampleWeatherResponse,
      );
    });

    test('handles errors correctly', () async {
      final container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
        ],
      );

      final exception = Exception('Failed to fetch');
      when(
        () => mockWeatherRepository.fetchWeather(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenAnswer((_) async => throw exception);

      // initial read triggers build which throws
      final state = container.read(weatherViewModelProvider);

      // Since it's async, we might need to wait for the next event loop
      await Future.delayed(Duration.zero);

      final finalState = container.read(weatherViewModelProvider);
      expect(finalState.hasError, true);
      expect(finalState.error, exception);
    });
  });
}
