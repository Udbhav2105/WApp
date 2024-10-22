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
      required this.iconUrl,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,color: Colors.black54),
          ),
          SizedBox(
            height: 10,
          ),
          Container(

            width: MediaQuery.of(context).size.width * 0.3,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Image.network(
                  iconUrl,
                  height: 80,
                ),
                Text(
                  temp.toStringAsFixed(0) + "°C",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Text(
            date,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black54),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}