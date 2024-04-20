// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class PhoneAuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class PhoneAuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class PhoneAuthScreenLoaded extends AuthState {
  final int id;
  final String type;

  PhoneAuthScreenLoaded({required this.id, required this.type});

  @override
  List<Object?> get props => [id, type];
}

class PhoneAuthErrorState extends AuthState {
  final String err;

  PhoneAuthErrorState({required this.err});
  @override
  List<Object?> get props => [err];
}

class PhoneAuthCodeSent extends AuthState {
  final String verificationId;

  PhoneAuthCodeSent({required this.verificationId});
  @override
  List<Object?> get props => [verificationId];
}

class PhoneAuthSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

class UserExist extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthInValid extends AuthState {
  final String err;
  AuthInValid({required this.err});

  @override
  List<Object?> get props => [err];
}

class LogedOut extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoginScreenLoaded extends AuthState {
  @override
  List<Object?> get props => [];
}

class UpdateScreenLoaded extends AuthState {
  final int parentid;
  UpdateScreenLoaded({required this.parentid});

  @override
  List<Object?> get props => [];
}

class UpdatingLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class UpdatingErr extends AuthState {
  @override
  List<Object?> get props => [];
}
