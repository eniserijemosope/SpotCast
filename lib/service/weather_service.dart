import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../model/weather_model.dart';

class WeatherService {
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String city) async {
    final url =
        '$baseUrl?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to fetch weather.');
    }
  }

  Future<String> getCurrentCity() async {
    bool serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception(
        'Location services are disabled.',
      );
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception(
        'Location permission denied.',
      );
    }

    if (permission ==
        LocationPermission.deniedForever) {
      throw Exception(
        'Location permission permanently denied.',
      );
    }

    Position position =
        await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    final geocoding = Geocoding();
    List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return placemarks.first.locality ?? '';
  }
}

