// THIS IS HAS FUNCTIONALITY OF SIGNING
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/components/signin_button.dart';
import 'package:weather_app/services/auth.dart';

class SignInCard extends StatelessWidget {
  final AuthServices auth;

  const SignInCard({required this.auth, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 100),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.black12,
                ),
              ),
            ),
            const SizedBox(height: 100),
            SignInButton(
              text: "Continue without Signing In",
              icon: Icons.account_circle,
              onPressed: () async {
                await auth.signInAnonymously();
                print('here');
              },
            ),
            const SizedBox(height: 30),
            SignInButton(
              text: "Sign In with Google",
              icon: FontAwesomeIcons.google,
              onPressed: () async {
                await auth.signInWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
