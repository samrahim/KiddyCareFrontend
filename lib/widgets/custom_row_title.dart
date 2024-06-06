import 'package:flutter/material.dart';

class CustomTitleRow extends StatelessWidget {
  final String title;
  const CustomTitleRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
        ),
        const Text(
          "see all",
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w400, color: Colors.grey),
        )
      ],
    );
  }
}
