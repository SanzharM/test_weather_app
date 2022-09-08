import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_weather_app/presentation/theme/theme.dart';
import 'package:test_weather_app/presentation/widgets/weather/weather_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}
