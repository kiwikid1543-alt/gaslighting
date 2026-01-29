class Weather {
  final double latitude;
  final double longitude;
  // final double generationtimeMs;
  // final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentWeather currentWeather;

  Weather({
    required this.latitude,
    required this.longitude,
    // required this.generationtimeMs,
    // required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentWeather,
  });
}

class CurrentWeather {
  final double temperature;
  final double windspeed;
  final double winddirection;
  final int weathercode;
  final int isDay;
  final String time;

  CurrentWeather({
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.weathercode,
    required this.isDay,
    required this.time,
  });
}
