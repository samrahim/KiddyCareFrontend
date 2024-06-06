// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CircAvatar extends StatelessWidget {
  final String imagePath;

  const CircAvatar({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 55,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: imagePath == "default"
              ? Image.asset(
                  'images/mom-icon-in-cartoon-style-vector-8655229.jpg',
                  fit: BoxFit.cover,
                )
              : Image.network(imagePath, fit: BoxFit.cover)),
    );
  }
}
