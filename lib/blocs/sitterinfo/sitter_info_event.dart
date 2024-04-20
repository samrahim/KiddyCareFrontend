part of 'sitter_info_bloc.dart';

abstract class SitterInfoEvent extends Equatable {
  const SitterInfoEvent();

  @override
  List<Object> get props => [];
}

class GetSitterInfoEvent extends SitterInfoEvent {
  final int id;
  const GetSitterInfoEvent({required this.id});
  @override
  List<Object> get props => [id];
}
