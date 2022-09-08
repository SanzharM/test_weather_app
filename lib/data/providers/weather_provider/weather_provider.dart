import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:test_weather_app/Library/api/api_base.dart';
import 'package:test_weather_app/Library/api/endpoints.dart';
import 'package:test_weather_app/data/providers/app_provider.dart';
import 'package:test_weather_app/domain/entities/weather.dart';

class WeatherProvider extends AppProvider {
  Future<Weather?> getWeather(double lat, double lng) async {
    final response = await api.request(
      url: ApiEndpoints.forecast,
      method: Method.get,
      queryParameters: {'latitude': lat, 'longitude': lng, 'hourly': 'temperature_2m'},
    );
    if (response.isSuccess) {
      return await compute(parseWeather, response.poorResponse?.data);
    }
    return null;
  }

  static Weather? parseWeather(dynamic data) {
    return Weather.fromMap(data);
    try {} catch (e) {
      debugPrint('Unable to parse weather: $e');
    }
    return null;
  }
}
