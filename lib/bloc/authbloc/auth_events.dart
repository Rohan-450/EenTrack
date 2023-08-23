import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInit extends AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogin({required this.email, required this.password});
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventRegister({required this.email, required this.password});
}

class AuthEventLogout extends AuthEvent {}

class AuthEventLoginAnonymously extends AuthEvent {}

class AuthEventSendEmailVerification extends AuthEvent {}

class AuthEventVerifyEmail extends AuthEvent {}

class AuthEventShowRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventShowRegister({
    this.email = '',
    this.password = '',
  });
}

class AuthEventShowLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEventShowLogin({
    this.email = '',
    this.password = '',
  });
}

class AuthEventShowVerifyEmail extends AuthEvent {
  final String email;
  const AuthEventShowVerifyEmail({
    this.email = '',
  });
}
