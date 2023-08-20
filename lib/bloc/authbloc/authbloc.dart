import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_f/firebase_options.dart';
import 'package:project_f/services/authservices/auth_exception.dart';
import 'package:project_f/services/authservices/authmodel.dart';

import 'auth_events.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthModel authProvider) : super(AuthStateUninitialized()) {
    // Initialize the app
    on<AuthEventInit>(
      (event, emit) async {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        final user = authProvider.user;
        if (user == null) {
          emit(AuthStateNeedLogin());
        } else {
          if (user.isVerified ?? false) {
            emit(AuthStateLoggedIn(user: user));
          } else {
            emit(AuthStateNeedVerify());
          }
        }
      },
    );

    // Need login event
    on<AuthEventShowLogin>(
      (event, emit) {
        final email = event.email;
        final password = event.password;

        emit(AuthStateNeedLogin(
          email: email,
          password: password,
        ));
      },
    );

    // Need register event
    on<AuthEventShowRegister>(
      (event, emit) {
        final email = event.email;
        final password = event.password;
        emit(AuthStateNeedRegister(
          email: email,
          password: password,
        ));
      },
    );

    // Show verify event
    on<AuthEventShowVerifyEmail>((event, emit) {
      emit(AuthStateNeedVerify());
    });

    // Login Event
    on<AuthEventLogin>((event, emit) async {
      var email = event.email;
      var password = event.password;
      emit(AuthStateNeedLogin(
        email: email,
        password: password,
        loading: 'Logging in...',
      ));

      try {
        var user = await authProvider.loginWithEmail(email, password);
        if (user == null) {
          emit(AuthStateNeedLogin(
            email: email,
            password: password,
            error: 'Invalid email or password',
          ));
          return;
        }
        if (!(user.isVerified ?? false)) {
          emit(AuthStateNeedVerify());
          return;
        }
        emit(AuthStateLoggedIn(user: user));
      } on AuthException catch (e) {
        emit(AuthStateNeedLogin(
          email: email,
          password: password,
          error: e.message,
        ));
      }
    });

    // Register Event
    on<AuthEventRegister>((event, emit) async {
      var email = event.email;
      var password = event.password;
      emit(AuthStateNeedRegister(
        email: email,
        password: password,
        loading: 'Registering...',
      ));
      try {
        var user = await authProvider.registerWithEmail(email, password);
        if (user == null) {
          emit(AuthStateNeedRegister(
            email: email,
            password: password,
            error: 'Invalid email or password',
          ));
          return;
        }
        emit(AuthStateNeedVerify());
      } on AuthException catch (e) {
        emit(AuthStateNeedRegister(
          email: email,
          password: password,
          error: e.message,
        ));
      }
    });

    // Login Anonymously
    on<AuthEventLoginAnonymously>((event, emit) async {
      emit(AuthStateNeedLogin(loading: 'Logging in...'));
      try {
        var user = await authProvider.loginAnnonymously();
        if (user == null) {
          emit(AuthStateNeedLogin(
            error: 'Error logging in anonymously',
          ));
          return;
        }
        emit(AuthStateLoggedIn(user: user));
      } on AuthException catch (e) {
        return emit(AuthStateNeedLogin(
          error: e.message,
        ));
      } catch (e) {
        return emit(AuthStateNeedLogin(
          error: e.toString(),
        ));
      }
    });

    // Event Logout
    on<AuthEventLogout>((event, emit) async {
      emit(AuthStateNeedLogin(loading: 'Logging out...'));
      await authProvider.logout();
      emit(AuthStateNeedLogin());
    });

		// Send email verification
    on<AuthEventSendEmailVerification>((event, emit) async {
      emit(AuthStateNeedVerify(loading: 'Sending verification email...'));
      await authProvider.sendEmailVerification();
      emit(AuthStateNeedVerify());
    });

    // Verify email
    on<AuthEventVerifyEmail>((event, emit) async {
      emit(AuthStateNeedVerify(loading: 'Verifying email...'));
      try {
        var user = await authProvider.currentUser;
        if (user == null) {
          emit(AuthStateNeedLogin(error: 'User not found'));
          return;
        }
        if (user.isVerified ?? false) {
          emit(AuthStateLoggedIn(user: user));
          return;
        }
        emit(AuthStateNeedVerify(error: 'Email not verified'));
      } on AuthException catch (e) {
        emit(AuthStateNeedVerify(error: e.message));
      }
    });
  }
}
