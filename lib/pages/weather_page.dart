import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api/weather%20api.dart';
import 'package:weather_app/components/Today_weather.dart';
import 'package:weather_app/components/fortnight_list.dart';
import 'package:weather_app/components/hourly_list.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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
    Future.delayed(Duration.zero, () {
      setupWeatherPage();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: [
                  SafeArea(
                    child: TodayWeather(data: data),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(0.1),
                    ),
                    child: Text(
                      "Next 15 Days",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3f6096),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.fortNight!['data'].length,
                      itemBuilder: (context, index) {
                        final dayWeather = data.fortNight!['data'][index];

                        final String date =
                            dayWeather['datetime'] ?? 'Unknown date';

                        final double temp = (dayWeather['temp'] is int)
                            ? (dayWeather['temp'] as int).toDouble()
                            : dayWeather['temp'] ?? 0.0;

                        final String iconCode =
                            dayWeather['weather']['icon'] ?? 'default';
                        final String iconUrl =
                            'https://www.weatherbit.io/static/img/icons/$iconCode.png';

                        return FortnightList(
                          date: date,
                          iconUrl: iconUrl,
                          temp: temp,
                        );
                      },
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: data.hourly.length,
                          itemBuilder: (context, index) {
                            final hourlyWeather = data.hourly[index];
                            final DateTime datetime = DateTime.parse(hourlyWeather['timestamp_local']);
                            final String date = DateFormat('dd/mm').format(datetime);
                            final String time = DateFormat('H:mm').format(datetime);
                            final double temp = (hourlyWeather['temp'] is int)
                                ? (hourlyWeather['temp'] as int).toDouble()
                                : hourlyWeather['temp'] ?? 0.0;
                            final String iconCode =
                                hourlyWeather['weather']['icon'] ?? 'default';
                            final String iconUrl =
                                'https://www.weatherbit.io/static/img/icons/$iconCode.png';
                            return HourlyList(
                              date:date,
                              time: time,
                              iconUrl: iconUrl,
                              temp:temp,
                            );
                          }))
                ],
              ),
            ),
    );
  }
}
