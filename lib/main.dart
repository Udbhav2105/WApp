import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/pages/firebase_login.dart';
import 'package:weather_app/pages/search_page.dart';
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
   try {
    await dotenv.load();  // Ensure the dotenv is loaded
  } catch (e) {
    print("Error loading .env file: $e");  // Catch and print error if dotenv fails
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: AuthServices().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            print("Auth State Changed: ${user != null ? 'Signed In' : 'Signed Out'}");

            if (user != null) {
              // User signed in
              print('sending to searchLoc');
              return const SearchLoc();
            } else {
              // User not signed in
              print(user);
              // print("here");
              return  FirebaseLogin();
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      routes: {
        '/weatherPage': (context) => const WeatherPage(),
        '/15days': (context) => const FortnightForecast(),
      },
    );
  }
}
