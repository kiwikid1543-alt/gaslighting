import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gaslighting/data/model/weather_dto.dart';
import 'package:flutter_gaslighting/data/repository/weather_repository_impl.dart';
import 'package:flutter_gaslighting/presentaion/page/weather_screen.dart';
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

  Widget createTestWidget() {
    return ProviderScope(
      overrides: [
        weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
      ],
      child: const MaterialApp(home: WeatherScreen()),
    );
  }

  group('WeatherScreen Widget Tests', () {
    testWidgets('shows loading indicator when data is being fetched', (
      WidgetTester tester,
    ) async {
      final completer = Completer<WeatherResponse>();
      when(
        () => mockWeatherRepository.fetchWeather(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenAnswer((_) => completer.future);

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows weather data when fetch is successful', (
      WidgetTester tester,
    ) async {
      when(
        () => mockWeatherRepository.fetchWeather(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenAnswer((_) async => sampleWeatherResponse);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Weather App'), findsOneWidget);
      expect(find.text('25.0 °C'), findsOneWidget);
      expect(find.text('Asia/Seoul (KST)'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);
    });

    testWidgets('shows error message and retry button when fetch fails', (
      WidgetTester tester,
    ) async {
      when(
        () => mockWeatherRepository.fetchWeather(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenAnswer((_) async => throw Exception('Failed to fetch weather'));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Error: Exception: Failed to fetch weather'),
        findsOneWidget,
      );
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('clicking refresh button triggers a re-fetch', (
      WidgetTester tester,
    ) async {
      when(
        () => mockWeatherRepository.fetchWeather(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenAnswer((_) async => sampleWeatherResponse);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Click the refresh icon in app bar
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pump();

      verify(
        () => mockWeatherRepository.fetchWeather(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).called(2); // One for build, one for refresh
    });
  });
}
