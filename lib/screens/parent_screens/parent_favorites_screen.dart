import 'package:flutter/material.dart';

class ParentFavoritesScreen extends StatefulWidget {
  const ParentFavoritesScreen({super.key});

  @override
  State<ParentFavoritesScreen> createState() => _ParentFavoritesScreenState();
}

class _ParentFavoritesScreenState extends State<ParentFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text("ParentFavoritesScreen"),
      ),
    );
  }
}
