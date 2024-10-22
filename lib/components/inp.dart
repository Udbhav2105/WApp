// THIS IS THE INPUT BOX FOR SEARCH PAGE
import 'package:flutter/material.dart';
import 'package:weather_app/services/app_color.dart';

class InputBox extends StatefulWidget {
  final String inputText;
  final TextEditingController controller;

  const InputBox(
      {super.key, required this.inputText, required this.controller});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color:AppColor.secondaryColor,
                  width: 2.0,
                ),
              ),
              labelText: widget.inputText,
              labelStyle: const TextStyle(color: AppColor.primaryColor),
            ),
          ),
        )
      ],
    );
  }
}
