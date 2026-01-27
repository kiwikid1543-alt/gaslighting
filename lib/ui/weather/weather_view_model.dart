import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/model/weather_model.dart';
import '../../data/repository/weather_repository.dart';
import 'package:http/http.dart' as http;

// Repository Provider
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepositoryImpl(http.Client());
});

// ViewModel (AsyncNotifier)
class WeatherViewModel extends AsyncNotifier<WeatherResponse> {
  @override
  FutureOr<WeatherResponse> build() {
    return _fetchWeather();
  }

  Future<WeatherResponse> _fetchWeather() {
    // Hardcoded location as per request
    final repository = ref.read(weatherRepositoryProvider);
    return repository.fetchWeather(latitude: 37.57, longitude: 126.98);
  }

  Future<void> fetchWeather() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchWeather());
  }
}

// ViewModel Provider
final weatherViewModelProvider =
    AsyncNotifierProvider<WeatherViewModel, WeatherResponse>(() {
      return WeatherViewModel();
    });
