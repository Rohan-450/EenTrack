import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_f/services/authservices/authmodel.dart';
import 'package:project_f/services/authservices/authuser.dart';

class FirebaseAuthService implements AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AuthUser?> loginWithEmail(String email, String password) async {
    final res = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebaseUser(res.user);
  }

  @override
  Future<AuthUser?> registerWithEmail(String email, String password) async {
    final res = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebaseUser(res.user);
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  AuthUser? get user => _userFromFirebaseUser(_auth.currentUser);
}

AuthUser? _userFromFirebaseUser(User? user) {
  return user != null
      ? AuthUser(
          uid: user.uid, email: user.email, isVerified: user.emailVerified)
      : null;
}
