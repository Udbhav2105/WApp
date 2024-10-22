import 'package:flutter/material.dart';
import 'package:weather_app/services/app_color.dart';

class LocationList extends StatelessWidget {
  final String location;
  final VoidCallback? onRemove;
  const LocationList({super.key, required this.location, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:AppColor.secondaryColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            location,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color:AppColor.primaryColor,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color:AppColor.primaryColor,
            ),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
