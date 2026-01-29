import 'dart:async';
import 'package:flutter_gaslighting/domain/entity/weather.dart';
import 'package:flutter_gaslighting/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repository Provider

// ViewModel (AsyncNotifier)
class WeatherScreenViewModel extends AsyncNotifier<Weather> {
  // 초기화 로직
  @override
  FutureOr<Weather> build() {
    return _fetchWeather();
  }

  // 데이터 로드 로직
  Future<Weather> _fetchWeather() {
    // Hardcoded location as per request
    final useCase = ref.read(fetchWeatherUseCaseProvider);
    return useCase.execute(37.57, 126.98);
  }

  // 데이터 갱신 로직
  Future<void> fetchWeather() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchWeather());
  }
}

// ViewModel Provider
final weatherViewModelProvider =
    AsyncNotifierProvider<WeatherScreenViewModel, Weather>(() {
      return WeatherScreenViewModel();
    });
