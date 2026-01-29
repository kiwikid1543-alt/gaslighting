import 'package:flutter_gaslighting/domain/entity/weather.dart';

abstract interface class WeatherRepository {
  Future<Weather> fetchWeather({
    // 위도와 경도는 왜 여기에 놓고, 여기에 놔두어도 되는건가?
    required double latitude,
    required double longitude,
  });
}
