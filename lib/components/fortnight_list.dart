import 'package:flutter/material.dart';

class FortnightList extends StatelessWidget {
  final String iconUrl;
  final String date;
  final String weekday;
  final highTemp;
  final lowTemp;

  const FortnightList(
      {super.key,
      required this.iconUrl,
      required this.date,
      day,
      required this.weekday, this.highTemp, this.lowTemp});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(2, 0, 2, 5),
        decoration: const BoxDecoration(
            // color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weekday,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Text(
                lowTemp.toStringAsFixed(0) + '/' + highTemp.toStringAsFixed(0) + '°C',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Image.network(
                iconUrl,
                height: 80,
              ),
            ],
          ),
        ));
  }
}
