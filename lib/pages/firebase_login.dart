import 'package:flutter/material.dart';
import 'package:weather_app/components/app_title.dart';
import 'package:weather_app/components/signin_card.dart';
import 'package:weather_app/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirebaseLogin extends StatelessWidget {
  final AuthServices _auth = AuthServices();

  FirebaseLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFcde1fc),
      body: SafeArea(
        child: Column(
          children: [
            const AppTitle(),
            Expanded(
              child: SignInCard(auth: _auth),
            ),
          ],
        ),
      ),
    );
  }
}

