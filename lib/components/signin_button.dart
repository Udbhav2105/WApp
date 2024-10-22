// THIS IS THE BUTTON FOR SIGNING IN
import 'package:flutter/material.dart';
import 'package:weather_app/services/app_color.dart';

class SignInButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const SignInButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.78,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.secondaryColor,
          minimumSize: const Size(200, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color:AppColor.primaryColor,
                letterSpacing: 0.7,
                fontSize: 17,
              ),
            ),
            Icon(icon, color: AppColor.primaryColor),
          ],
        ),
      ),
    );
  }
}
