import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:test_weather_app/data/providers/weather_provider/weather_provider.dart';
import 'package:test_weather_app/domain/entities/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final _weatherProvider = WeatherProvider();

  void getWeather(double lat, double lng) => add(GetWeatherEvent(lat: lat, lng: lng));
  void getLocation() => add(GetLocation());

  WeatherBloc(WeatherState initialState) : super(initialState) {
    on<WeatherEvent>((event, emit) async {
      if (event is GetLocation) {
        final location = await Location().getLocation();
        debugPrint('${location.latitude} ${location.longitude}');
        // emit();
        if (location.latitude != null && location.longitude != null) {
          getWeather(location.latitude!, location.longitude!);
        }
      }
      if (event is GetWeatherEvent) {
        final data = await _weatherProvider.getWeather(event.lat, event.lng);
        try {
          emit(WeatherLoading());

          final data = await _weatherProvider.getWeather(event.lat, event.lng);

          if (data != null) {
            return emit(WeatherLoadedState(data));
          } else {
            return emit(ErrorState('Something went wrong'));
          }
        } catch (e) {
          debugPrint('$e');
        }
      }
    });
    getLocation();
  }
}
