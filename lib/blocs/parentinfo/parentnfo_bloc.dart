import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:babysitter/models/famille.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'parentnfo_event.dart';
part 'parentnfo_state.dart';

class ParentnfoBloc extends Bloc<ParentnfoEvent, ParentnfoState> {
  ParentnfoBloc() : super(ParentnfoInitial()) {
    on<ParentnfoEvent>((event, emit) {});
    on<GetParentInfoEvent>((event, emit) async {
      emit(ParentInfoLoading());
      try {
        final response =
            await http.get(Uri.parse("$baseUrl/famille/info/${event.id}"));
        emit(ParentinfoLoaded(
            model: FamilleModel.fromJson(json.decode(response.body))));
      } catch (e) {
        emit(ParentInfoLoadingErr(err: e.toString()));
      }
    });
  }
}
