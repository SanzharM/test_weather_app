part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetLocation extends WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {
  final double lat;
  final double lng;

  GetWeatherEvent({required this.lat, required this.lng});
}
