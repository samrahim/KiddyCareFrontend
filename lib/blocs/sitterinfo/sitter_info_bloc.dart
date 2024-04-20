import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:babysitter/models/sitter.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'sitter_info_event.dart';
part 'sitter_info_state.dart';

class SitterInfoBloc extends Bloc<SitterInfoEvent, SitterInfoState> {
  SitterInfoBloc() : super(SitterInfoInitial()) {
    on<SitterInfoEvent>((event, emit) {});
    on<GetSitterInfoEvent>((event, emit) async {
      emit(SitterInfoLoading());
      try {
        final response =
            await http.get(Uri.parse("$baseUrl/sitter/info/${event.id}"));
        emit(SitterinfoLoaded(
            model: SitterModel.fromJson(json.decode(response.body))));
      } catch (e) {
        emit(SitterInfoLoadingErr(err: e.toString()));
      }
    });
  }
}
