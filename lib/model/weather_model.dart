class Weather {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final String mainCondition;
  final String description;
  final String icon;
  final int sunrise;
  final int sunset;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.mainCondition,
    required this.description,
    required this.icon,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],

      temperature: (json['main']['temp'] as num).toDouble(),

      feelsLike: (json['main']['feels_like'] as num).toDouble(),

      humidity: json['main']['humidity'],

      pressure: json['main']['pressure'],

      windSpeed: (json['wind']['speed'] as num).toDouble(),

      mainCondition: json['weather'][0]['main'],

      description: json['weather'][0]['description'],

      icon: json['weather'][0]['icon'],

      sunrise: json['sys']['sunrise'],

      sunset: json['sys']['sunset'],
    );
  }
}