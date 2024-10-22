// THIS IS THE LOGIN PAGE
import 'package:flutter/material.dart';
import 'package:weather_app/components/app_title.dart';
import 'package:weather_app/components/signin_card.dart';
import 'package:weather_app/services/app_color.dart';
import 'package:weather_app/services/auth.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirebaseLogin extends StatelessWidget {
  final AuthServices _auth = AuthServices();

  FirebaseLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppTitle(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: SignInCard(auth: _auth),
              ),
            ),
          ],
        ),
      ),
    );

  }
}

