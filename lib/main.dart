import 'package:flutter/material.dart';
import 'package:weather_app/pages/firebase_login.dart';
import 'package:weather_app/pages/search%20page.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/pages/fortnight_forecast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/services/auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: AuthServices().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            print(
                "Auth State Changed: ${user != null ? 'Signed In' : 'Signed Out'}");
            print(user);
            if (user != null) {
              return const SearchLoc();
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => FirebaseLogin()));
              });
              return const SizedBox(); // Return an empty widget while navigating
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      routes: {
        // '/': (context) => const SearchLoc(),
        '/weatherPage': (context) => const WeatherPage(),
        '/15days': (context) => const FortnightForecast(),
      },
    );
  }
}
