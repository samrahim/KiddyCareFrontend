import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'sitter_bottom_navigation_bar_event.dart';
part 'sitter_bottom_navigation_bar_state.dart';

class SitterBottomNavigationBarBloc extends Bloc<SitterBottomNavigationBarEvent,
    SitterBottomNavigationBarState> {
  int primary;
  List<Widget> pages;
  SitterBottomNavigationBarBloc({this.primary = 0, required this.pages})
      : super(SitterBottomNavigationBarInitial(primary, pages[primary])) {
    on<SitterBottomNavigationBarEvent>((event, emit) {
      if (event is SitterNavigateToScreen) {
        primary = event.index;
        emit(SitterNewScreen(primary, newWidget: pages[primary]));
      }
    });
  }
}
