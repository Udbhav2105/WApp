import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';

class HourlyList extends StatelessWidget {
  final String date;
  final double temp;
  final String time;
  final String iconUrl;

  const HourlyList(
      {super.key,
      required this.date,
      required this.temp,
      required this.iconUrl, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
      ),
      child: Column(
        children: [
          Container(
            
          ),
          Image.network(iconUrl,height: 80,),
          Text(
            'Date: ${date}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(time),
          Text(
            'Temperature: ${temp.toString()}°C',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
