import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_weather_app/domain/blocs/weather_bloc/weather_bloc.dart';
import 'package:test_weather_app/presentation/widgets/custom_shimmer.dart';
import 'package:test_weather_app/presentation/widgets/weather/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherBloc, WeatherState>(
        bloc: WeatherBloc(WeatherInitial()),
        listener: (context, state) => debugPrint('state is $state'),
        builder: (_, state) {
          final isLoaded = state is WeatherLoadedState;
          if (isLoaded && (state.weather.hours?.isEmpty ?? true) && (state.weather.temperatures?.isEmpty ?? true)) {
            return const Center(child: Text('none'));
          }
          return CustomShimmer(
            isLoading: state is WeatherLoading,
            child: Row(
              children: [
                Flexible(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: isLoaded ? (state.weather.hours?.length ?? 0) : 5,
                    separatorBuilder: (_, sep) => const SizedBox(width: 8.0),
                    itemBuilder: (_, i) {
                      return WeatherCard(
                        time: isLoaded && state.weather.hours != null ? state.weather.hours![i] : DateTime.now(),
                        temperature: isLoaded && state.weather.temperatures != null ? state.weather.temperatures![i] : 0.0,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
