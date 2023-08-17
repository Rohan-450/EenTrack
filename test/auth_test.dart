import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_f/services/authservices/firebase_auth_service.dart';

void main() {
  test('Test anonymous login', () async {
		WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final auth = FirebaseAuthService.instance;
    final user = await auth.loginAnnonymously();
    expect(user, isNotNull);
    if (user != null) {
      log(user.uid);
      expect(user.uid, isNotNull);
      expect(user.email, isNull);
      expect(user.isVerified, isFalse);
    }
  });
}
