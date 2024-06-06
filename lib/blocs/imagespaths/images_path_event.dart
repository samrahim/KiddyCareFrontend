part of 'images_path_bloc.dart';

abstract class ImagesPathEvent extends Equatable {}

class SaveFronIdCardPath extends ImagesPathEvent {
  final String frontIdPath;

  SaveFronIdCardPath({required this.frontIdPath});
  @override
  List<Object?> get props => [frontIdPath];
}

class SaveBackIdCard extends ImagesPathEvent {
  final String backIdPath;

  SaveBackIdCard({required this.backIdPath});
  @override
  List<Object?> get props => [backIdPath];
}

class GetImagesPaths extends ImagesPathEvent {
  @override
  List<Object?> get props => [];
}
