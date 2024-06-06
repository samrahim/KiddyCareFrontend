import 'package:babysitter/repositories/imagespaths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'images_path_event.dart';
part 'images_path_state.dart';

class ImagesPathBloc extends Bloc<ImagesPathEvent, ImagesPathState> {
  ImagesPaths paths;
  ImagesPathBloc({required this.paths}) : super(ImagesPathInitial()) {
    on<SaveFronIdCardPath>((event, emit) {
      paths.frontIdPath = event.frontIdPath;
    });
    on<SaveBackIdCard>((event, emit) {
      paths.backIdPath = event.backIdPath;
    });
    on<GetImagesPaths>((event, emit) {
      emit(ImagesLoaded(paths: paths));
    });
  }
}
