import 'dart:convert';

import 'package:flutter_gaslighting/data/data_source/weather_data_source.dart';
import 'package:flutter_gaslighting/data/dto/weather_dto.dart';
import 'package:http/http.dart' as http;

class WeatherDataSourceImpl implements WeatherDataSource {
  final http.Client client;

  WeatherDataSourceImpl(this.client);

  @override
  Future<WeatherDto> fetchWeather(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return WeatherDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
