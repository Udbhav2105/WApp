import 'package:flutter/material.dart';
import 'package:weather_app/pages/search%20page.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/pages/fortnight_forecast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const SearchLoc(),
      '/weatherPage': (context) => WeatherPage(),
      '/15days': (context) => FortnightForecast(),
    },
  ));
}
