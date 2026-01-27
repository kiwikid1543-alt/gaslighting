import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherResponse> fetchWeather({
    required double latitude,
    required double longitude,
  });
}

class WeatherRepositoryImpl implements WeatherRepository {
  final http.Client client;

  WeatherRepositoryImpl(this.client);

  @override
  Future<WeatherResponse> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
