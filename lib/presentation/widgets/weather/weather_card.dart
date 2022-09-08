import 'package:flutter/material.dart';
import 'package:test_weather_app/domain/entities/weather.dart';
import 'package:test_weather_app/presentation/theme/app_colors.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({Key? key, required this.time, required this.temperature}) : super(key: key);

  final DateTime time;
  final double temperature;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(color: AppColors.lightGrey),
      child: Column(
        children: [
          Text('$temperature C'),
          Text(time.toString()),
        ],
      ),
    );
  }
}
