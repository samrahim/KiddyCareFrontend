import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

// int parentId=;
// List<Widget> pages = [
//   const ParentHomeScreen(),
//   const ParentFavoritesScreen(),
//   const ParentAddScreen(),
//   const ParentMessagesScreen(parentId: parentId),
//   const ParentProfileScreen(),
// ];

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  int primary;
  List<Widget> pages;
  BottomNavigationBloc({this.primary = 0, required this.pages})
      : super(BottomNavigationInitial(primary, pages[primary])) {
    on<BottomNavigationEvent>((event, emit) {
      if (event is NavigateToEvent) {
        primary = event.index;
        emit(TakeNewScreen(primary, newWidget: pages[primary]));
      }
    });
  }
}
