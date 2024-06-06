import 'dart:convert';
import 'package:babysitter/consts.dart';
import 'package:babysitter/models/sitter.model.dart';
import 'package:babysitter/repositories/firebase_messaging_repository.dart';
import 'package:babysitter/repositories/imagespaths.dart';
import 'package:babysitter/repositories/sitter_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
part 'sitterauthbloc_state.dart';
part 'sitterauthbloc_event.dart';

class SitterauthblocBloc
    extends Bloc<SitterauthblocEvent, SitterauthblocState> {
  ImagesPaths paths;
  SitterAuthRepository sitterAuthRepository;
  FirebaseMessaginRepository firebaseMessaginRepository;
  SitterauthblocBloc(
      {required this.paths,
      required this.sitterAuthRepository,
      required this.firebaseMessaginRepository})
      : super(SitterauthblocInitial()) {
    on<SitterSendOtpToPhoneNumber>((event, emit) async {
      emit(SitterPhoneAuthLoadingState());
      try {
        await sitterAuthRepository.regiterWithPhone(
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
              add(SitterOnPhoneOtpSend(
                  verificationId: verificationId, token: token!));
            },
            verificationFailed: (err) {
              add(SitterOnPhoneAuthErrorEvent(err: err.toString()));
            },
            codeAutoretivalTimout: (s) {});
      } catch (e) {
        emit(SitterPhoneAuthErrorState(err: e.toString()));
      }
    });

    on<SitterOnPhoneOtpSend>((event, emit) {
      emit(SitterPhoneAuthCodeSent(verificationId: event.verificationId));
    });

    on<SitterLoginEventTest>((event, emit) async {
      final res = await sitterAuthRepository.loginSitter(
          sitterPhone: event.sitterPhone,
          sitterEmail: event.sitterEmail,
          sitterPassword: event.sitterPassword);

      if (res == "Incorrect Info !") {
        emit(SitterAuthInValid());
      } else {
        emit(SitterPhoneAuthScreenLoaded(
            model: SitterModel.fromJson(json.decode(res))));
      }
    });
    on<UpdateSitterImgAndLoc>((event, emit) {
      try {
        sitterAuthRepository.uploadFileAndUpdateSitterInfo(
            baseUrl: baseUrl,
            sitterId: event.sitterId,
            latitude: event.latitude,
            longitude: event.longitude,
            defaultAddress: event.sitteradress,
            image: event.sitterimg);
        emit(SitterUpdatingLoading());
        emit(UpdateSitterBioScreenLoaded(sitterId: event.sitterId));
      } catch (e) {
        emit(SitterUpdatingErr());
      }
    });
    on<SitterVerifyOtp>((event, emit) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: event.verificationId, smsCode: event.otp);
        add(OnPhoneAuhtSuccess(
          credential: credential,
          phone: event.phoneNumber,
          userName: event.userName,
          password: event.password,
          email: event.email,
        ));
      } catch (e) {
        emit(SitterPhoneAuthErrorState(err: e.toString()));
      }
    });

    on<SitterOnPhoneAuthErrorEvent>((event, emit) {
      emit(SitterPhoneAuthErrorState(err: event.err));
    });
    on<SitterLogoutEvent>((event, emit) {
      emit(SitterLogedOut());
    });
    on<SitterNavigateToUpdateScreen>((event, emit) {
      emit(SitterUpdateScreenLoaded(sitterId: event.sitterid));
    });
    on<UpdateSitterBioAndExperience>((event, emit) async {
      final res = await sitterAuthRepository.updateBioSitter(
          sitterId: event.sitterId,
          bio: event.bio,
          sitterExperiance: event.experience);
      print("res========$res");
      if (res == 200) {
        emit(PickFrontIdState());
      } else {
        emit(SitterUpdatingErr());
      }
    });
    // on<UpdateSitterSkills>((event, emit) {

    // });
    on<SendFrontAndBackIdCardsEvent>((event, emit) async {
      emit(SendCardIdLoading());
      try {
        await sitterAuthRepository
            .sendFrontAndBackId(
                customerId: sitterAuthRepository.sitterId,
                frontId: paths.frontIdPath!,
                backId: paths.backIdPath!)
            .then((val) async {
          if (val.statusCode == 200) {
            emit(SendCardIdSuccess());
          } else {
            emit(SendCardIdFailed(err: await val.stream.bytesToString()));
          }
        });
      } catch (e) {
        emit(SendCardIdFailed(err: e.toString()));
      }
    });
    on<OnPhoneAuhtSuccess>((event, emit) async {
      final token = await firebaseMessaginRepository.getFcmToken();
      try {
        SitterModel sitter = SitterModel(
            sitterName: event.userName,
            sitterPhone: event.phone,
            sitterPassword: event.password,
            sitterFcmToken: token ?? "",
            sitterEmail: event.email,
            sitterImagePath: '');

        final res = await sitterAuthRepository.registerSitter(sitter);

        if (json.decode(res) == "this user has been registred") {
          emit(SitterUserExist());
        } else if (json.decode(res)['success'] == 'true') {
          add(SitterNavigateToUpdateScreen(
              sitterid: json.decode(res)['res']['sitterId']));
        }
      } catch (e) {
        emit(SitterPhoneAuthErrorState(err: e.toString()));
      }
    });
  }
}
