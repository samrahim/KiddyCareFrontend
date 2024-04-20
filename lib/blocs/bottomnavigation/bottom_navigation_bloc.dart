import 'package:babysitter/screens/parent_screens/parent_add_screen.dart';
import 'package:babysitter/screens/parent_screens/parent_favorites_screen.dart';
import 'package:babysitter/screens/parent_screens/parent_home_screen.dart';
import 'package:babysitter/screens/parent_screens/parent_messages_screen.dart';
import 'package:babysitter/screens/parent_screens/parent_profil_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

List<Widget> pages = [
  const ParentHomeScreen(),
  const ParentFavoritesScreen(),
  const ParentAddScreen(),
  const ParentMessagesScreen(),
  const ParentProfileScreen(),
];

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  int primary;
  BottomNavigationBloc({this.primary = 0})
      : super(BottomNavigationInitial(primary, pages[primary])) {
    on<BottomNavigationEvent>((event, emit) {
      if (event is NavigateToEvent) {
        primary = event.index;
        emit(TakeNewScreen(primary, newWidget: pages[primary]));
      }
    });
  }
}
