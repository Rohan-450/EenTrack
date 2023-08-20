import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_f/services/authservices/authmodel.dart';
import 'package:project_f/services/authservices/authuser.dart';

import 'auth_exception.dart';

class FirebaseAuthService implements AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Makes it singletion DONT TOUCH IT
  static FirebaseAuthService get instance => _instance;
  FirebaseAuthService._();
  static final _instance = FirebaseAuthService._();

  @override
  Future<AuthUser?> loginWithEmail(String email, String password) async {
    try {
      final res = await _auth.signInAnonymously();
      return _userFromFirebaseUser(res.user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw AuthException('Invalid email address');
        case 'wrong-password':
          throw AuthException('Wrong password');
        case 'user-not-found':
          throw AuthException('User not found');
        default:
          throw AuthException('Unknown error');
      }
    } catch (e) {
      throw AuthException('Unknown error');
    }
  }

  @override
  Future<AuthUser?> loginAnnonymously() async {
    try {
      final res = await _auth.signInAnonymously();
      return _userFromFirebaseUser(res.user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw AuthException('Invalid email address');
        case 'wrong-password':
          throw AuthException('Wrong password');
        case 'user-not-found':
          throw AuthException('User not found');
        default:
          throw AuthException('Unknown error');
      }
    } catch (e) {
      throw AuthException('Unknown error');
    }
  }

  @override
  Future<AuthUser?> registerWithEmail(String email, String password) async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(res.user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw AuthException('Invalid email address');
        case 'email-already-in-use':
          throw AuthException('Email already in use');
        case 'weak-password':
          throw AuthException('Password too weak');
        default:
          throw AuthException('Unknown error');
      }
    } catch (e) {
      throw AuthException('Unknown error');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw AuthException('User not found');
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  AuthUser? get user => _userFromFirebaseUser(_auth.currentUser);

  @override
  Future<AuthUser?> get currentUser async {
    final user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    try {
      await user.reload();
    } catch (e) {
      throw AuthException('Unknown error');
    }
    return _userFromFirebaseUser(user);
  }

  AuthUser? _userFromFirebaseUser(User? user) {
    return user != null
        ? AuthUser(
            uid: user.uid,
            email: user.email,
            isVerified: user.emailVerified,
          )
        : null;
  }
}
