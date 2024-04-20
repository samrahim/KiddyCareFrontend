import 'package:babysitter/screens/sitter_screens.dart/sitter_bookings_screen.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_jobs_screen.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_messages_screen.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sitter_bottom_navigation_bar_event.dart';
part 'sitter_bottom_navigation_bar_state.dart';

List<Widget> pages = [
  const SitterJobsScreen(),
  const SitterBookingsScreen(),
  const SitterMessagesScreen(),
  const SitterProfileScreen(),
];

class SitterBottomNavigationBarBloc extends Bloc<SitterBottomNavigationBarEvent,
    SitterBottomNavigationBarState> {
  int primary;
  SitterBottomNavigationBarBloc({this.primary = 0})
      : super(SitterBottomNavigationBarInitial(primary, pages[primary])) {
    on<SitterBottomNavigationBarEvent>((event, emit) {
      if (event is SitterNavigateToScreen) {
        primary = event.index;
        emit(SitterNewScreen(primary, newWidget: pages[primary]));
      }
    });
  }
}
