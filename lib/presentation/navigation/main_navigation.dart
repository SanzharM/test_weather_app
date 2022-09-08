import 'package:flutter/material.dart';
import 'package:test_weather_app/presentation/widgets/weather/weather_screen.dart';

abstract class MainNavigationRouteNames {
  static const loaderWidget = '/';
  static const mainScreen = '/main_screen';
}

class MainNavigation {
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.loaderWidget: (_) => Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.white.withOpacity(0.33),
          child: const CircularProgressIndicator.adaptive(),
        ),
    MainNavigationRouteNames.mainScreen: (_) => const WeatherScreen(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.mainScreen:
        return MaterialPageRoute(builder: (_) => const WeatherScreen());
      // case MainNavigationRouteNames.movieDetails:
      //   final arguments = settings.arguments;
      //   final movieId = arguments is int ? arguments : 0;
      //   return MaterialPageRoute(
      //     builder: (_) => _screenFactory.makeMovieDetails(movieId),
      //   );
      // case MainNavigationRouteNames.movieTrailerWidget:
      //   final arguments = settings.arguments;
      //   final youtubeKey = arguments is String ? arguments : '';
      //   return MaterialPageRoute(
      //     builder: (_) => _screenFactory.makeMovieTrailer(youtubeKey),
      //   );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.loaderWidget,
      (route) => false,
    );
  }
}
