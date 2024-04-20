part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  final int ind;
  final Widget page;

  const BottomNavigationState(this.ind, this.page);

  @override
  List<Object> get props => [ind, page];
}

class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial(super.ind, super.page);

  @override
  List<Object> get props => [ind, page];
}

class TakeNewScreen extends BottomNavigationState {
  final Widget newWidget;
  final int inde;
  const TakeNewScreen(this.inde, {required this.newWidget})
      : super(inde, newWidget);
  @override
  List<Object> get props => [newWidget];
}
