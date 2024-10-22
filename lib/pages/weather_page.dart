import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/app_color.dart';
import 'package:weather_app/services/auth.dart';
import 'package:weather_app/services/weather api.dart';
import 'package:weather_app/components/today_weather.dart';
import 'package:weather_app/components/hourly_list.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherData weatherData;
  final AuthServices _auth = AuthServices();
  late Map<String, dynamic> data;
  bool isLoading = true;

  void setupWeatherPage() async {
    data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print(data['location']);
    print(data['coordinates']);
    weatherData = WeatherData(data['location']);
    await weatherData.getCurrWeather(
        data['coordinates']['lat'], data['coordinates']['lon']);
    await weatherData.getFiveDayForecast(
        data['coordinates']['lat'], data['coordinates']['lon']);
    await weatherData.hourlyData(
        data['coordinates']['lat'], data['coordinates']['lon']);
    // print('is loading false');
    // print(weatherData.fortNight);
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
      // print('Signing out...');
      await _auth.signOut();
      Navigator.pop(context);
      print('User signed out.');
    } else if (option == "Change Location") {
      Navigator.pop(context, data);
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
          : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: [
                  SafeArea(child: TodayWeather(data: weatherData)),
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
                            Navigator.pushNamed(context, '/15days',
                                arguments: weatherData);
                          },
                          child: Text(
                            "Next 15 Days",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color:AppColor.primaryColor,
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
                      children:
                          List.generate(weatherData.hourly.length, (index) {
                        final hourlyWeather = weatherData.hourly[index];
                        final DateTime datetime =
                            DateTime.parse(hourlyWeather['timestamp_local']);
                        final String date =
                            DateFormat('dd MMM').format(datetime);
                        final String time =
                            DateFormat('H:mm a').format(datetime);
                        final double temp = (hourlyWeather['temp'] is int)
                            ? (hourlyWeather['temp'] as int).toDouble()
                            : hourlyWeather['temp'] ?? 0.0;
                        final String iconCode =
                            hourlyWeather['weather']['icon'] ?? 'default';
                        final String iconUrl =
                            'https://www.weatherbit.io/static/img/icons/$iconCode.png';
            
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
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
          ),
    );
  }
}