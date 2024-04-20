part of 'sitter_bottom_navigation_bar_bloc.dart';

abstract class SitterBottomNavigationBarState extends Equatable {
  final int ind;
  final Widget page;

  const SitterBottomNavigationBarState(this.ind, this.page);
}

class SitterBottomNavigationBarInitial extends SitterBottomNavigationBarState {
  const SitterBottomNavigationBarInitial(super.ind, super.page);

  @override
  List<Object?> get props => [ind, page];
}

class SitterNewScreen extends SitterBottomNavigationBarState {
  final Widget newWidget;
  final int inde;
  const SitterNewScreen(this.inde, {required this.newWidget})
      : super(inde, newWidget);
  @override
  List<Object> get props => [newWidget];
}
