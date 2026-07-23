import 'package:flutter/material.dart';

class AdditionWidget extends StatelessWidget {
  final IconData icon;
  final String name;
  final String number;
  const AdditionWidget({
    super.key,
    required this.icon,
    required this.name,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 35),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(number, style: const TextStyle(fontSize: 22)),
      ],
    );
  }
}
