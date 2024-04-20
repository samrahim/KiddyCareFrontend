import 'package:babysitter/blocs/sitterbottomnavigation/sitter_bottom_navigation_bar_bloc.dart';
import 'package:babysitter/blocs/sitterinfo/sitter_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SitterInitLayout extends StatefulWidget {
  final int id;
  const SitterInitLayout({super.key, required this.id});

  @override
  State<SitterInitLayout> createState() => _InitLayoutState();
}

class _InitLayoutState extends State<SitterInitLayout> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SitterBottomNavigationBarBloc>(
            create: (context) => SitterBottomNavigationBarBloc()),
        BlocProvider(
          create: (context) =>
              SitterInfoBloc()..add(GetSitterInfoEvent(id: widget.id)),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.indigo,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: BlocBuilder<SitterBottomNavigationBarBloc,
                  SitterBottomNavigationBarState>(builder: (context, state) {
                return GNav(
                  selectedIndex: state.ind,
                  onTabChange: (value) {
                    context
                        .read<SitterBottomNavigationBarBloc>()
                        .add(SitterNavigateToScreen(index: value));
                  },
                  backgroundColor: Colors.indigo,
                  color: Colors.cyanAccent,
                  activeColor: Colors.indigo,
                  tabBackgroundColor: Colors.cyanAccent,
                  padding: const EdgeInsets.all(12),
                  gap: 6,
                  tabs: const [
                    GButton(
                        textSize: 30,
                        text: "jobd",
                        icon: Icons.home,
                        textStyle: TextStyle(overflow: TextOverflow.ellipsis)),
                    GButton(
                        textSize: 30,
                        text: "bookings",
                        icon: Icons.book,
                        textStyle: TextStyle(overflow: TextOverflow.ellipsis)),
                    GButton(
                        text: "Messages",
                        icon: Icons.message_outlined,
                        textStyle: TextStyle(overflow: TextOverflow.ellipsis)),
                    GButton(
                        text: "Profil",
                        icon: Icons.person,
                        textStyle: TextStyle(overflow: TextOverflow.ellipsis)),
                  ],
                );
              }),
            ),
          ),
          body: BlocBuilder<SitterBottomNavigationBarBloc,
              SitterBottomNavigationBarState>(builder: (context, state) {
            return state.page;
          }),
        ),
      ),
    );
  }
}
