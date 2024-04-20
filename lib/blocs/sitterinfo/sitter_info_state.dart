part of 'sitter_info_bloc.dart';

abstract class SitterInfoState extends Equatable {
  const SitterInfoState();

  @override
  List<Object> get props => [];
}

class SitterInfoInitial extends SitterInfoState {}

class SitterInfoLoading extends SitterInfoState {}

class SitterinfoLoaded extends SitterInfoState {
  final SitterModel model;
  const SitterinfoLoaded({required this.model});
  @override
  List<Object> get props => [model];
}

class SitterInfoLoadingErr extends SitterInfoState {
  final String err;

  const SitterInfoLoadingErr({required this.err});
  @override
  List<Object> get props => [err];
}
