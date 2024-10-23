import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherData {
  late final String city;
  late String description;
  late double temp;
  late int pressure;
  late int humidity;
  late double wind;
  late double longitude;
  late double latitude;
  late String icon;
  late dynamic fortNight;
  late dynamic hourly;

  WeatherData(this.city);

  // THIS FUNCTION FETCHES WEATHER DATA FROM THE INPUT LATITUDE AND LONGITUDE
  Future<bool> getCurrWeather(double latitude, double longitude) async {
    try {
      final apiKey = dotenv.env['OPENWEATHER'];
      if (apiKey == null) {
        print("API Key not found");
        return false;
      }
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}&units=metric"));

      if (response.statusCode == 200) {
        final b = jsonDecode(response.body);

        temp = b['main']['feels_like'].toDouble();
        pressure = b['main']['pressure'];
        humidity = b['main']['humidity'];
        wind = b['wind']['speed'].toDouble();

        description = b['weather'][0]['description'];
        icon = b['weather'][0]['icon'];
        return true;
      } else {
        print("Error fetching weather data");
        return false;
      }
    } catch (e) {
      print("The error is $e");
      return false;
    }
  }

  // THIS FUNCTION FETCHES LONGITUDE AND LATITUDE OF THE LOCATION
  Future<bool> getLonLat() async {
    final apiKey = dotenv.env['OPENWEATHER'];
    if (apiKey == null) {
      print("API Key not found");
      return false;
    }

    Response response = await get(Uri.parse(
        "http://api.openweathermap.org/geo/1.0/direct?q=${city}&appid=${apiKey}"));

    if (response.statusCode == 200) {
      final b = jsonDecode(response.body);

      if (b.isNotEmpty) {
        longitude = b[0]['lon'].toDouble();
        latitude = b[0]['lat'].toDouble();
        print("Latitude: $latitude, Longitude: $longitude");
      } else {
        print("Location not found");
        return false;
      }
      return true;
    } else {
      print("Error fetching location");
      return false;
    }
  }

  // THIS FUNCTION FETCHES DATA OF 15 DAYS
  Future<void> get15DayForecast(double latitude, double longitude) async {
    final weatherbitKey = dotenv.env['WEATHERBIT'];
    if (weatherbitKey == null) {
      print("Weatherbit API Key not found");
      return;
    }

    var url =
        "https://api.weatherbit.io/v2.0/forecast/daily?lat=${latitude}&lon=${longitude}&key=${weatherbitKey}";
    var response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      fortNight = data;
    } else {
      print('Failed to load data: ${response.body}');
    }
  }

  // THIS FUNCTION FETCHES HOURLY DATA
  Future<void> hourlyData(double latitude, double longitude) async {
    final weatherbitKey = dotenv.env['WEATHERBIT'];
    if (weatherbitKey == null) {
      print("Weatherbit API Key not found");
      return;
    }
    var url =
        "https://api.weatherbit.io/v2.0/forecast/hourly?lat=${latitude}&lon=${longitude}&key=${weatherbitKey}&hours=24";
    var response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      hourly = data;
    } else {
      print('Failed to load data: ${response.body}');
    }
  }
}
