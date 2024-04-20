part of 'sitter_bottom_navigation_bar_bloc.dart';

abstract class SitterBottomNavigationBarEvent extends Equatable {}

class SitterNavigateToScreen extends SitterBottomNavigationBarEvent {
  final int index;

  SitterNavigateToScreen({required this.index});
  @override
  List<Object> get props => [index];
}
