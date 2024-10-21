import 'package:flutter/material.dart';

class LocationList extends StatelessWidget {
  final String location;
  final VoidCallback? onRemove;
  const LocationList({super.key, required this.location, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFcde1fc).withOpacity(0.6),
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
              color: Color(0xFF3f6096),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Color(0xFF3f6096),
            ),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
