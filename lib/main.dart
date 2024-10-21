import 'package:flutter/material.dart';
import 'package:weather_app/pages/search%20page.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/pages/fortnight_forecast.dart';
void main() => runApp(MaterialApp(

      initialRoute: '/',
      routes: {
        '/': (context) => const SearchLoc(),
        '/weatherPage': (context) =>  WeatherPage(),
        '/15days':(context) => FortnightForecast(),
      },
    ));
