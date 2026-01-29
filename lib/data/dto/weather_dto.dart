class WeatherDto {
  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentWeatherDto currentWeather;

  WeatherDto({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentWeather,
  });

  factory WeatherDto.fromJson(Map<String, dynamic> json) {
    return WeatherDto(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      generationtimeMs: (json['generationtime_ms'] as num).toDouble(),
      utcOffsetSeconds: json['utc_offset_seconds'] as int,
      timezone: json['timezone'] as String,
      timezoneAbbreviation: json['timezone_abbreviation'] as String,
      elevation: (json['elevation'] as num).toDouble(),
      currentWeather: CurrentWeatherDto.fromJson(
        json['current_weather'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'generationtime_ms': generationtimeMs,
      'utc_offset_seconds': utcOffsetSeconds,
      'timezone': timezone,
      'timezone_abbreviation': timezoneAbbreviation,
      'elevation': elevation,
      'current_weather': currentWeather.toJson(),
    };
  }
}

class CurrentWeatherDto {
  final double temperature;
  final double windspeed;
  final double winddirection;
  final int weathercode;
  final int isDay;
  final String time;

  CurrentWeatherDto({
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.weathercode,
    required this.isDay,
    required this.time,
  });

  factory CurrentWeatherDto.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherDto(
      temperature: (json['temperature'] as num).toDouble(),
      windspeed: (json['windspeed'] as num).toDouble(),
      winddirection: (json['winddirection'] as num).toDouble(),
      weathercode: json['weathercode'] as int,
      isDay: json['is_day'] as int,
      time: json['time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'windspeed': windspeed,
      'winddirection': winddirection,
      'weathercode': weathercode,
      'is_day': isDay,
      'time': time,
    };
  }
}
