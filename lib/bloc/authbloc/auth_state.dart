import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';
import 'package:project_f/services/authservices/authuser.dart';

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

class AuthStateLoading extends AuthState {}

class AuthStateLoggedIn extends AuthState with EquatableMixin {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthStateNeedLogin extends AuthState with EquatableMixin {
  final String email;
  final String password;
  AuthStateNeedLogin({
    this.email = '',
    this.password = '',
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
  final String email;
  final String password;
  AuthStateNeedRegister({
    this.email = '',
    this.password = '',
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
  final String email;
  AuthStateNeedVerify({
    required this.email,
    String? loading,
    String? error,
  }) : super(
          loading: loading,
          error: error,
        );
  @override
  List<Object?> get props => [error, loading];
}
