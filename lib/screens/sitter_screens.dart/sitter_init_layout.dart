import 'package:babysitter/blocs/sitterbottomnavigation/sitter_bottom_navigation_bar_bloc.dart';
import 'package:babysitter/blocs/sitterinfo/sitter_info_bloc.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_bookings_screen.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_jobs_screen.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_messages_screen.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_profile_screen.dart';
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
            create: (context) => SitterBottomNavigationBarBloc(
                  pages: [
                    const SitterJobsScreen(),
                    const SitterBookingsScreen(),
                    SitterMessagesScreen(sitterId: widget.id),
                    const SitterProfileScreen(),
                  ],
                )),
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
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: BlocBuilder<SitterBottomNavigationBarBloc,
                  SitterBottomNavigationBarState>(builder: (context, state) {
                return GNav(
                  onTabChange: (value) {
                    context
                        .read<SitterBottomNavigationBarBloc>()
                        .add(SitterNavigateToScreen(index: value));
                  },
                  textStyle: TextStyle(color: Colors.purple.shade300),
                  selectedIndex: state.ind,
                  backgroundColor: Colors.white,
                  color: Colors.purple.shade300,
                  activeColor: Colors.blue.shade900,
                  tabBackgroundColor: Colors.purple.shade300,
                  padding: const EdgeInsets.all(12),
                  gap: 6,
                  tabs: const [
                    GButton(
                        textSize: 30,
                        text: "jobs",
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
