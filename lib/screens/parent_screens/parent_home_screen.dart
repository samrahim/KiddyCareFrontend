import 'package:babysitter/blocs/parentinfo/parentnfo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: BlocBuilder<ParentnfoBloc, ParentnfoState>(
                builder: (context, state) {
              if (state is ParentinfoLoaded) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: state.model.familleImagePath == ""
                      ? Image.asset(
                          "images/mom-icon-in-cartoon-style-vector-8655229.jpg")
                      : Image.network(state.model.familleImagePath!),
                );
              } else {
                return const SizedBox();
              }
            }),
            title: BlocBuilder<ParentnfoBloc, ParentnfoState>(
                builder: (context, state) {
              if (state is ParentinfoLoaded) {
                return Text("hi , ${state.model.familleName}");
              } else {
                return const SizedBox();
              }
            }),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.purple.shade300,
                  ))
            ],
          ),
          body: Container()),
    );
  }
}
