import 'dart:convert';
import 'package:babysitter/consts.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:babysitter/models/famille.model.dart';
import 'package:babysitter/repositories/famille_auth_repository.dart';
import 'package:babysitter/repositories/firebase_messaging_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FamilleAuthRepository authrepository;
  FirebaseMessaginRepository firebaseMessaginRepository;
  AuthBloc(
      {required this.authrepository, required this.firebaseMessaginRepository})
      : super(PhoneAuthInitial()) {
    on<SendOtpToPhoneNumber>((event, emit) async {
      emit(PhoneAuthLoadingState());
      try {
        await authrepository.regiterWithPhone(
            phoneNumber: event.phoneNumber,
            verificationCompleted: (credential) {
              add(OnPhoneAuhtSuccess(
                  credential: credential,
                  phone: event.phoneNumber,
                  userName: event.userName,
                  password: event.password,
                  email: event.email));
            },
            codeSent: (String verificationId, int? token) {
              add(OnPhoneOtpSend(
                  verificationId: verificationId, token: token!));
            },
            verificationFailed: (err) {
              add(OnPhoneAuthErrorEvent(err: err.toString()));
            },
            codeAutoretivalTimout: (s) {});
      } catch (e) {
        emit(PhoneAuthErrorState(err: e.toString()));
      }
    });

    on<OnPhoneOtpSend>((event, emit) {
      emit(PhoneAuthCodeSent(verificationId: event.verificationId));
    });

    on<LoginEventTest>((event, emit) async {
      final res = await authrepository.login(
          event.parentPhone, event.parentEmail,
          famillePassword: event.parentPassword);

      if (res == "Incorrect Info !") {
        emit(AuthInValid(err: res));
      } else {
        emit(PhoneAuthScreenLoaded(
          // model: FamilleModel.fromJson(json.decode(res))
          id: json.decode(res)['id'],
          type: "Parent",
        ));
      }
    });
    on<VerifyOtp>((event, emit) {
      try {
        final creq = PhoneAuthProvider.credential(
            verificationId: event.verificationId, smsCode: event.otp);
        add(OnPhoneAuhtSuccess(
          credential: creq,
          phone: event.phoneNumber,
          userName: event.userName,
          password: event.password,
          email: event.email,
        ));
      } catch (e) {
        emit(PhoneAuthErrorState(err: e.toString()));
      }
    });

    on<OnPhoneAuthErrorEvent>((event, emit) {
      emit(PhoneAuthErrorState(err: event.err));
    });
    on<UpdateParentInfo>((event, emit) {
      try {
        authrepository.uploadFileAndUpdateParentInfo(
            baseUrl, event.parentId, event.adress, event.img);
        emit(UpdatingLoading());
        emit(LoginScreenLoaded());
      } catch (e) {
        emit(UpdatingErr());
      }
    });
    on<LogoutEvent>((event, emit) {
      emit(LogedOut());
    });
    on<NavigateToLogin>((event, emit) {
      emit(LoginScreenLoaded());
    });

    on<OnPhoneAuhtSuccess>((event, emit) async {
      final token = await firebaseMessaginRepository.getFcmToken();

      try {
        FamilleModel familleModel = FamilleModel(
            familleName: event.userName,
            famillePhone: event.phone,
            famillePassword: event.password,
            familleFcmToken: token ?? "",
            familleImagePath: null,
            familleAdress: '',
            familleEmail: event.email);
        final res = await authrepository.registerfamille(familleModel);
        if (json.decode(res) ==
            "Failed to register Famille SequelizeUniqueConstraintError: Validation error") {
          emit(UserExist());
        } else if (json.decode(res)['success'] == 'true') {
          add(NavigateToUpdateScreen(id: json.decode(res)['res']['id']));
        }
      } catch (e) {
        emit(PhoneAuthErrorState(err: e.toString()));
      }
    });
    on<NavigateToUpdateScreen>((event, emit) {
      emit(UpdateScreenLoaded(parentid: event.id));
    });
  }
}
