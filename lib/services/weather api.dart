import 'dart:convert';
import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'package:weather/weather.dart';

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

  Future<bool> getCurrWeather(double latitude,double longitude) async {
    print('getCurrWeather being called');
    print("input values of this func is are ${latitude}, ${longitude}");
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=2b659a6b68178648847b3ab6d4992818&units=metric"));

    try {
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

  Future<bool> getLonLat() async {
    Response response = await get(Uri.parse(
        "http://api.openweathermap.org/geo/1.0/direct?q=${city}&appid=2b659a6b68178648847b3ab6d4992818"));

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

  Future<void> getFiveDayForecast(double latitude,double longitude) async {
    print('getFiveDayForecast being called');
    print("input values of this func is are ${latitude}, ${longitude}");
    var url =
        "https://api.weatherbit.io/v2.0/forecast/daily?lat=${latitude}&lon=${longitude}&key=d5b43d318855402190b443044a6db4ee";
    var response = await get(Uri.parse(url));

    // print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map<String,dynamic>;
      fortNight = data;
      // print(fortNight);
    } else {
      print(
          'Failed to load data: ${response.body}');
    }
  }

  Future<void> hourlyData(double latitude,double longitude) async {
    print('hourly data being called');
    print("input values of this func is are ${latitude}, ${longitude}");
    var url =
        "https://api.weatherbit.io/v2.0/forecast/hourly?lat=${latitude}&lon=${longitude}&key=d5b43d318855402190b443044a6db4ee&hours=24";
    var response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      hourly = data;
      // print(hourly);
    } else {
      print(
          'Failed to load data: ${response.body}');
    }
  }
}