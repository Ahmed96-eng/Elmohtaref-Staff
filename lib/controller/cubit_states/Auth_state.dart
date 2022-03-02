import 'package:mohtaref/model/auth_model.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthRefreshgState extends AuthState {}

class AppGetCachedSuccessState extends AuthState {}

/// TimerCount
class AppStartTimerCountDownState extends AuthState {}

class AppStopTimerCountDownState extends AuthState {}

/// TimerCount
class AuthLoginLoadingState extends AuthState {}

class AutLoginSuccessState extends AuthState {
  final AuthModelModel? authModelModel;

  AutLoginSuccessState(this.authModelModel);
}

class AuthLoginErrorState extends AuthState {}

class AuthRegisterLoadingState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {
  final AuthModelModel? authModelModel;

  AuthRegisterSuccessState(this.authModelModel);
}

class AuthRegisterErrorState extends AuthState {}

class ChangeShowPasswordState extends AuthState {}

/// service
class AuthServicesLoadingState extends AuthState {}

class AutServicesSuccessState extends AuthState {}

/// get profile image
class PickedProfileImageSuccessState extends AuthState {}

class PickedProfileImageErrorState extends AuthState {}

/// get passport image
class PickedPassportImageSuccessState extends AuthState {}

class PickedPassportImageErrorState extends AuthState {}

class AuthServicesErrorState extends AuthState {}

/// SMSorEmail

class SendSMSorEmailLoadingState extends AuthState {}

class SendSMSorEmailSuccessState extends AuthState {}

class SendSMSorEmailErrorState extends AuthState {}
//otp

class SendOTPLoadingState extends AuthState {}

class SendOTPSuccessState extends AuthState {}

class SendOTPErrorState extends AuthState {}

//new password

class SetNewPasswordLoadingState extends AuthState {}

class SetNewPasswordSuccessState extends AuthState {}

class SetNewPasswordErrorState extends AuthState {}
