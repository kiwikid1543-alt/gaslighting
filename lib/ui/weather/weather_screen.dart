import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'weather_view_model.dart';
import '../../data/model/weather_model.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(weatherViewModelProvider.notifier).fetchWeather();
            },
          ),
        ],
      ),
      body: weatherState.when(
        data: (weather) => _buildWeatherContent(weather),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error', style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(weatherViewModelProvider.notifier).fetchWeather(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildWeatherContent(WeatherResponse weather) {
    final current = weather.currentWeather;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(
            'Location',
            '${weather.latitude}, ${weather.longitude}',
          ),
          _buildInfoCard(
            'Timezone',
            '${weather.timezone} (${weather.timezoneAbbreviation})',
          ),
          _buildInfoCard('Elevation', '${weather.elevation} m'),
          const Divider(height: 32),
          const Text(
            'Current Weather',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoCard('Temperature', '${current.temperature} °C'),
          _buildInfoCard('Wind Speed', '${current.windspeed} km/h'),
          _buildInfoCard('Wind Direction', '${current.winddirection}°'),
          _buildInfoCard('Weather Code', '${current.weathercode}'),
          _buildInfoCard('Is Day', current.isDay == 1 ? 'Day' : 'Night'),
          _buildInfoCard('Time', current.time),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
