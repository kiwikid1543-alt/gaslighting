import 'package:flutter_gaslighting/data/data_source/weather_data_source.dart';
import 'package:flutter_gaslighting/data/data_source/weather_data_source_impl.dart';
import 'package:flutter_gaslighting/data/repository/weather_repository_impl.dart';
import 'package:flutter_gaslighting/domain/repository/weather_repository.dart';
import 'package:flutter_gaslighting/domain/usecase/fetch_weather_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// 데이터소스
final weatherDataSourceProvider = Provider<WeatherDataSource>((ref) {
  // http 패키지 대신 dio 패키지로 통신 도구를 바꾸고 싶다면,
  // 앱의 다른 모든 코드를 고치는 게 아니라 오직 이 프로바이더 안의
  // return 부분만 고치면 됨
  return WeatherDataSourceImpl(http.Client());
});

// 레포지토리
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final dataSource = ref.read(weatherDataSourceProvider);
  return WeatherRepositoryImpl(dataSource);
});

// 유스케이스(비지니스 로직)
final fetchWeatherUseCaseProvider = Provider<FetchWeatherUseCase>((ref) {
  final repository = ref.read(weatherRepositoryProvider);
  return FetchWeatherUseCase(repository);
});
