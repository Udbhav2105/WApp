import 'package:flutter/material.dart';

class FortnightList extends StatelessWidget {
  final String iconUrl;
  final String date;
  final String weekday;
  final temp;

  const FortnightList(
      {super.key,
      required this.iconUrl,
      this.temp,
      required this.date,
      day,
      required this.weekday});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(2, 0, 2, 5),
        decoration: BoxDecoration(
            // color: Colors.blue.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
          Radius.circular(10),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weekday,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  Text(
                    date,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
              Text(
                temp.toString() + '°C',
                style: TextStyle(
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
