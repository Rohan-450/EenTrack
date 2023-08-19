import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';

@immutable
class AuthState {
  final String? loading;
  final String? error;
  const AuthState({
    this.loading = 'Please wait...',
    this.error = 'Something went wrong!',
  });
}

class AuthStateUninitialized extends AuthState {}

class AuthStateLoaing extends AuthState {}

class AuthStateLoggedIn extends AuthState {}

class AuthStateNeedLogin extends AuthState with EquatableMixin {
  AuthStateNeedLogin({
    String? loading,
    String? error,
  }) : super(
          loading: loading,
          error: error,
        );
  @override
  List<Object?> get props => [error, loading];
}

class AuthStateNeedRegister extends AuthState with EquatableMixin {
  AuthStateNeedRegister({
    String? loading,
    String? error,
  }) : super(
          loading: loading,
          error: error,
        );
  @override
  List<Object?> get props => [error, loading];
}

class AuthStateNeedVerify extends AuthState with EquatableMixin {
  AuthStateNeedVerify({
    String? loading,
    String? error,
  }) : super(
          loading: loading,
          error: error,
        );
  @override
  List<Object?> get props => [error, loading];
}
