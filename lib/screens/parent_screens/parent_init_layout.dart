import 'package:babysitter/blocs/bottomnavigation/bottom_navigation_bloc.dart';
import 'package:babysitter/blocs/parentinfo/parentnfo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ParentInitLayout extends StatefulWidget {
  final int id;
  const ParentInitLayout({super.key, required this.id});

  @override
  State<ParentInitLayout> createState() => _InitLayoutState();
}

class _InitLayoutState extends State<ParentInitLayout> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBloc>(
            create: (context) => BottomNavigationBloc()),
        BlocProvider(
          create: (context) =>
              ParentnfoBloc()..add(GetParentInfoEvent(id: widget.id)),
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
              child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                  builder: (context, state) {
                return GNav(
                  selectedIndex: state.ind,
                  onTabChange: (value) {
                    context
                        .read<BottomNavigationBloc>()
                        .add(NavigateToEvent(index: value));
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
                        text: "Home",
                        icon: Icons.home,
                        textStyle: TextStyle(overflow: TextOverflow.ellipsis)),
                    GButton(
                        textSize: 30,
                        text: "Favorites",
                        icon: Icons.favorite_border,
                        textStyle: TextStyle(overflow: TextOverflow.ellipsis)),
                    GButton(
                        textSize: 30,
                        text: "Add",
                        icon: Icons.add_circle_outline_sharp,
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
          body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
              builder: (context, state) {
            return state.page;
          }),
        ),
      ),
    );
  }
}
