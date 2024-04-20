// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SendOtpToPhoneNumber extends AuthEvent {
  final String phoneNumber;
  final String userName;
  final String password;
  final String email;
  SendOtpToPhoneNumber(
      {required this.phoneNumber,
      required this.userName,
      required this.email,
      required this.password});
  @override
  List<Object?> get props => [phoneNumber];
}

class OnPhoneOtpSend extends AuthEvent {
  final String verificationId;
  final int token;

  OnPhoneOtpSend({required this.verificationId, required this.token});
  @override
  List<Object?> get props => [verificationId, token];
}

class VerifyOtp extends AuthEvent {
  final String otp;
  final String verificationId;
  final String phoneNumber;
  final String userName;
  final String password;
  final String email;
  VerifyOtp({
    required this.otp,
    required this.password,
    required this.verificationId,
    required this.phoneNumber,
    required this.userName,
    required this.email,
  });
  @override
  List<Object?> get props => [otp];
}

class OnPhoneAuthErrorEvent extends AuthEvent {
  final String err;

  OnPhoneAuthErrorEvent({required this.err});

  @override
  List<Object?> get props => [err];
}

class OnPhoneAuhtSuccess extends AuthEvent {
  final String userName;
  final String phone;
  final String password;
  final String email;
  final AuthCredential credential;

  OnPhoneAuhtSuccess({
    required this.password,
    required this.userName,
    required this.phone,
    required this.credential,
    required this.email,
  });

  @override
  List<Object?> get props => [credential];
}

class LoginEventTest extends AuthEvent {
  final String parentPhone;
  final String parentEmail;
  final String parentPassword;

  LoginEventTest(
      {required this.parentEmail,
      required this.parentPhone,
      required this.parentPassword});
  @override
  List<Object?> get props => [parentPhone, parentPassword];
}

class NavigateToLogin extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class NavigateToUpdateScreen extends AuthEvent {
  final int id;

  NavigateToUpdateScreen({required this.id});
  @override
  List<Object?> get props => [];
}

class UpdateParentInfo extends AuthEvent {
  final XFile? img;
  final String adress;
  final int parentId;

  UpdateParentInfo(
      {required this.parentId, required this.img, required this.adress});
  @override
  List<Object?> get props => [];
}
