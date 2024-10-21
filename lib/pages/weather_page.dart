import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/auth.dart';
import 'package:weather_app/services/weather api.dart';
import 'package:weather_app/components/Today_weather.dart';
import 'package:weather_app/components/hourly_list.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final AuthServices _auth = AuthServices();
  late WeatherData data;
  bool isLoading = true;

  void setupWeatherPage() async {
    data = ModalRoute.of(context)?.settings.arguments as WeatherData;
    await data.getCurrWeather();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, setupWeatherPage);
  }

  Future<void> _selectMenuOption(String option) async {
    if (option == "Sign Out") {
      print('Signing out...'); // Debug print
      await _auth.signOut(); // This should trigger the auth state change
      print('User signed out.'); // Debug print
    } else if (option == "Change Location") {
      // Implement Change Location logic if needed
      Navigator.pop(context, data); // Placeholder for future use
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: _selectMenuOption,
            itemBuilder: (BuildContext context) {
              return {'Change Location', 'Sign Out'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            SafeArea(child: TodayWeather(data: data)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " 24hrs",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/15days', arguments: data);
                    },
                    child: Text(
                      "Next 15 Days",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3f6096),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(data.hourly.length, (index) {
                  final hourlyWeather = data.hourly[index];
                  final DateTime datetime = DateTime.parse(hourlyWeather['timestamp_local']);
                  final String date = DateFormat('dd MMM').format(datetime);
                  final String time = DateFormat('H:mm a').format(datetime);
                  final double temp = (hourlyWeather['temp'] is int)
                      ? (hourlyWeather['temp'] as int).toDouble()
                      : hourlyWeather['temp'] ?? 0.0;
                  final String iconCode = hourlyWeather['weather']['icon'] ?? 'default';
                  final String iconUrl = 'https://www.weatherbit.io/static/img/icons/$iconCode.png';

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: HourlyList(
                      date: date,
                      time: time,
                      iconUrl: iconUrl,
                      temp: temp,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
