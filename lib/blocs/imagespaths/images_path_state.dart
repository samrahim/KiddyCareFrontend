part of 'images_path_bloc.dart';

abstract class ImagesPathState extends Equatable {}

class ImagesPathInitial extends ImagesPathState {
  @override
  List<Object?> get props => [];
}

class ImagesLoaded extends ImagesPathState {
  final ImagesPaths paths;

  ImagesLoaded({required this.paths});
  @override
  List<Object?> get props => [paths];
}
