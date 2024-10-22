import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        height: 150,
        child: const Text(
          "Weather App",
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3f6096),
          ),
        ),
      ),
    );
  }
}

