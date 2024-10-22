import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/weather%20api.dart';
import 'package:weather_app/components/fortnight_list.dart';

class FortnightForecast extends StatelessWidget {
  const FortnightForecast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final dynamic data =
    ModalRoute.of(context)?.settings.arguments as WeatherData;
    print('here in fortnight');
    print(data);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "15 Days Forecast",
          style: TextStyle(
            color: Colors.black54,
            letterSpacing: .2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: data.fortNight!['data'].length,
          itemBuilder: (context, index) {
            final dayWeather = data.fortNight!['data'][index];
            final DateTime datetime = DateTime.parse(dayWeather['datetime']);
            final String date = DateFormat('dd MMM').format(datetime);
            final String weekday = weekdays[datetime.weekday - 1];
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
              weekday: weekday,
            );
          },
        ),
      ),
    );
  }
}
