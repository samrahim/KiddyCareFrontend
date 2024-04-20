part of 'sitterauthbloc_bloc.dart';

abstract class SitterauthblocState extends Equatable {}

final class SitterauthblocInitial extends SitterauthblocState {
  @override
  List<Object?> get props => [];
}

class SitterPhoneAuthInitial extends SitterauthblocState {
  @override
  List<Object?> get props => [];
}

class SitterPhoneAuthLoadingState extends SitterauthblocState {
  @override
  List<Object?> get props => [];
}

class SitterPhoneAuthScreenLoaded extends SitterauthblocState {
  final SitterModel model;
  SitterPhoneAuthScreenLoaded({
    required this.model,
  });
  @override
  List<Object?> get props => [model];
}

class SitterPhoneAuthErrorState extends SitterauthblocState {
  final String err;

  SitterPhoneAuthErrorState({required this.err});
  @override
  List<Object?> get props => [err];
}

class SitterPhoneAuthCodeSent extends SitterauthblocState {
  final String verificationId;

  SitterPhoneAuthCodeSent({required this.verificationId});
  @override
  List<Object?> get props => [verificationId];
}

class SitterPhoneAuthSuccess extends SitterauthblocState {
  @override
  List<Object?> get props => [];
}

class SitterUserExist extends SitterauthblocState {
  @override
  List<Object?> get props => [];
}

// class AuthValid extends SitterauthblocState {
//   final ParentModel model;

//   AuthValid({required this.model});
//   @override
//   List<Object?> get props => [model];
// }

class SitterAuthInValid extends SitterauthblocState {
  @override
  List<Object?> get props => [];
}

class SitterLogedOut extends SitterauthblocState {
  @override
  List<Object?> get props => [];
}

class SitterLoginScreenLoaded extends SitterauthblocState {
  @override
  List<Object?> get props => [];
}

class SitterUpdateScreenLoaded extends SitterauthblocState {
  final int sitterId;
  SitterUpdateScreenLoaded({required this.sitterId});

  @override
  List<Object?> get props => [];
}

class SitterUpdatingLoading extends SitterauthblocState {
  @override
  List<Object?> get props => [];
}

class SitterUpdatingErr extends SitterauthblocState {
  @override
  List<Object?> get props => [];
}
