part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class ErrorState extends WeatherState {
  final String error;
  ErrorState(this.error);
}

class WeatherLoadedState extends WeatherState {
  final Weather weather;
  WeatherLoadedState(this.weather);
}
