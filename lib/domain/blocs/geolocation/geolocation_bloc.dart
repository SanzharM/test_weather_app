import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  GeolocationBloc() : super(GeolocationInitial()) {
    on<GeolocationEvent>((event, emit) {});
  }
}
