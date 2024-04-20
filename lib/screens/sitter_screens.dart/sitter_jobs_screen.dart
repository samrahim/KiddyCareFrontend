import 'package:babysitter/blocs/sitterinfo/sitter_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SitterJobsScreen extends StatefulWidget {
  const SitterJobsScreen({super.key});

  @override
  State<SitterJobsScreen> createState() => _SitterJobsScreenState();
}

class _SitterJobsScreenState extends State<SitterJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: BlocBuilder<SitterInfoBloc, SitterInfoState>(
            builder: (context, state) {
          if (state is SitterinfoLoaded) {
            return Text(state.model.sitterName);
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
