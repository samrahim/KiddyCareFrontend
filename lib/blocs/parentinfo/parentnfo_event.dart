part of 'parentnfo_bloc.dart';

abstract class ParentnfoEvent extends Equatable {
  const ParentnfoEvent();

  @override
  List<Object> get props => [];
}

class GetParentInfoEvent extends ParentnfoEvent {
  final int id;
  const GetParentInfoEvent({required this.id});
  @override
  List<Object> get props => [id];
}
