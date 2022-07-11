part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;

  AuthSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthRegisterSuccess extends AuthState {
  final UserModel user;

  AuthRegisterSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthResetPasswordSuccess extends AuthState {
  final UserModel user;

  AuthResetPasswordSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthForgetPasswordSuccess extends AuthState {
  final UserModel user;

  AuthForgetPasswordSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthResendOtpSuccess extends AuthState {
  final String mssg;

  AuthResendOtpSuccess(this.mssg);
  @override
  // TODO: implement props
  List<Object> get props => [mssg];
}

class AuthOtpSuccess extends AuthState {
  final UserModel user;

  AuthOtpSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthFailed extends AuthState {
  final String error;

  AuthFailed(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class AuthOtpFailed extends AuthState {
  final String error;

  AuthOtpFailed(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
