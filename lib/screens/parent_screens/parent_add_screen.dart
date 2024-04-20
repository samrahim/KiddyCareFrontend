import 'package:flutter/material.dart';

class ParentAddScreen extends StatefulWidget {
  const ParentAddScreen({super.key});

  @override
  State<ParentAddScreen> createState() => _ParentAddScreenState();
}

class _ParentAddScreenState extends State<ParentAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ParentAddScreen"),
      ),
    );
  }
}
