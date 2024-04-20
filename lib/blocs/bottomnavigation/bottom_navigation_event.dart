part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {}

class NavigateToEvent extends BottomNavigationEvent {
  final int index;

  NavigateToEvent({required this.index});
  @override
  List<Object> get props => [index];
}
