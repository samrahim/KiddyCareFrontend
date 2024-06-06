import 'package:flutter/material.dart';

class UserInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String?)? validator;
  final bool isPassword;
  final String hintText;
  final IconData icon;

  const UserInput(
      {super.key,
      required this.controller,
      this.validator,
      required this.isPassword,
      required this.hintText,
      required this.icon});

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator! as String? Function(String?)?,
        obscureText: widget.isPassword ? true : false,
        decoration: InputDecoration(
            suffixIcon: Icon(widget.icon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: widget.hintText),
      ),
    );
  }
}
