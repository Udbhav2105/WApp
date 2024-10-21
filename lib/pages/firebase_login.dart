import 'package:flutter/material.dart';
import 'package:weather_app/services/auth.dart';
import 'package:weather_app/components/inp.dart';
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
            Center(
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
            ),
            Expanded(
              child: Container(
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _auth.signInAnonymously();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Color(0xFFcde1fc),
                            minimumSize: Size(200, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Continue without Signing In",
                                style: TextStyle(
                                    color:  Color(0xFF3f6096),
                                    letterSpacing: 0.7,
                                    fontSize: 17),
                              ),
                              Icon(Icons.account_circle,color:Color(0xFF3f6096),),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: ElevatedButton(
                          onPressed: () async {
                            // await _auth.signInWithGoogle();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:Color(0xFFcde1fc),
                            minimumSize: Size(200, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sign In with Google",
                                style: TextStyle(
                                    color: Color(0xFF3f6096),
                                    letterSpacing: 0.7,
                                    fontSize: 17),
                              ),
                              FaIcon(FontAwesomeIcons.google,color: Color(0xFF3f6096),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
