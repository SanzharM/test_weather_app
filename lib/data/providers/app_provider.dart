import 'package:test_weather_app/Library/api/api_base.dart';

abstract class AppProvider {
  final _api = Api();

  Api get api => _api;
}
