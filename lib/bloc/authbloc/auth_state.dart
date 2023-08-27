import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';
import '../../services/authservices/authuser.dart';

@immutable
class AuthState {
  final String? loading;
  final String? error;
  const AuthState({
    this.loading,
    this.error,
  });
}

class AuthStateUninitialized extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLoggedIn extends AuthState with EquatableMixin {
  final AuthUser authuser;
  final User user;
  const AuthStateLoggedIn({required this.authuser, required this.user});

  @override
  List<Object?> get props => [authuser];
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

class AuthStateNeedDetails extends AuthState {
  final String email;
  const AuthStateNeedDetails({
    required this.email,
    String? loading,
    String? error,
  }) : super(
          loading: loading,
          error: error,
        );
}
