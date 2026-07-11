import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherAnimation extends StatelessWidget {
  final String? weatherCondition;

  const WeatherAnimation({
    super.key,
    required this.weatherCondition,
  });

  String getWeatherAnimation(String? condition) {
    if (condition == null) {
      return 'assets/animations/sunny.json';
    }

    switch (condition.toLowerCase()) {
      case 'clouds':
        return 'assets/animations/cloudy.json';

      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/animations/mist.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/animations/rain.json';

      case 'thunderstorm':
        return 'assets/animations/thunder.json';

      case 'snow':
        return 'assets/animations/snow.json';

      case 'clear':
        return 'assets/animations/sunny.json';

      default:
        return 'assets/animations/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      getWeatherAnimation(weatherCondition),
      fit: BoxFit.cover,
      repeat: true,
      animate: true,
    );
  }
}