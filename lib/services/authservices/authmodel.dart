import 'authuser.dart';

abstract class AuthModel {
  AuthUser? get user;
  Future<AuthUser?> loginWithEmail(String email, String password);
  Future<AuthUser?> registerWithEmail(String email, String password);
  Future<void> logout();
}
