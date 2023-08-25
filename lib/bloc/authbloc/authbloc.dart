import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_f/firebase_options.dart';
import 'package:project_f/services/authservices/auth_exception.dart';
import 'package:project_f/services/authservices/auth_model.dart';

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
          return;
        }
        if (user.isVerified ?? false) {
          emit(AuthStateLoggedIn(user: user));
          return;
        }
        emit(AuthStateNeedVerify(
          email: user.email!,
        ));
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
      emit(AuthStateNeedVerify(
        email: event.email,
      ));
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
          emit(AuthStateNeedVerify(
            email: user.email!,
          ));
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
        emit(AuthStateNeedVerify(
          email: user.email!,
        ));
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
      try {
        await authProvider.logout();
      } on AuthException catch (e) {
        emit(AuthStateNeedLogin(error: e.toString()));
      } catch (e) {
        emit(AuthStateNeedLogin(error: 'Something went wrong...'));
      }
      emit(AuthStateNeedLogin());
    });

    // Send email verification
    on<AuthEventSendEmailVerification>((event, emit) async {
      var user = authProvider.user;
      if (user == null) {
        return emit(AuthStateNeedLogin(error: 'User not found'));
      }
      emit(AuthStateNeedVerify(
          email: user.email!, loading: 'Sending verification email...'));
      await authProvider.sendEmailVerification();
      emit(AuthStateNeedVerify(
        email: user.email!,
      ));
    });

    // Verify email
    on<AuthEventVerifyEmail>((event, emit) async {
      var user = authProvider.user;

      if (user == null) {
        return emit(AuthStateNeedLogin(error: 'User not found'));
      }

      emit(AuthStateNeedVerify(
          email: user.email!, loading: 'Verifying email...'));
      try {
        user = await authProvider.currentUser;
        if (user == null) {
          emit(AuthStateNeedLogin(error: 'User not found'));
          return;
        }
        if (user.isVerified ?? false) {
          emit(AuthStateLoggedIn(user: user));
          return;
        }
        emit(AuthStateNeedVerify(
            email: user.email!, error: 'Email not verified'));
      } on AuthException catch (e) {
        emit(AuthStateNeedVerify(email: 'Unknown Email', error: e.message));
      }
    });
  }
}
