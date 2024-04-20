part of 'parentnfo_bloc.dart';

abstract class ParentnfoState extends Equatable {
  const ParentnfoState();

  @override
  List<Object> get props => [];
}

class ParentnfoInitial extends ParentnfoState {}

class ParentInfoLoading extends ParentnfoState {}

class ParentinfoLoaded extends ParentnfoState {
  final FamilleModel model;
  const ParentinfoLoaded({required this.model});
  @override
  List<Object> get props => [model];
}

class ParentInfoLoadingErr extends ParentnfoState {
  final String err;

  const ParentInfoLoadingErr({required this.err});
  @override
  List<Object> get props => [err];
}
