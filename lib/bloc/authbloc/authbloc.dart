import 'package:eentrack/models/user_model.dart';
import 'package:eentrack/services/dbservice/db_exception.dart';
import 'package:eentrack/services/dbservice/db_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import '../../firebase_options.dart';
import '../../services/authservices/auth_exception.dart';
import '../../services/authservices/auth_model.dart';
import 'auth_events.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthModel authProvider, DBModel dbprovider)
      : super(AuthStateUninitialized()) {
    // Initialize the app
    on<AuthEventInit>(
      (event, emit) async {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        await authProvider.init();
        await dbprovider.init();

        await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

        final authuser = authProvider.user;
        if (authuser == null) {
          emit(AuthStateNeedLogin());
          return;
        }
        if ((authuser.isVerified ?? false) == false) {
          emit(AuthStateNeedVerify(
            email: authuser.email!,
          ));
          return;
        }
        var user = await dbprovider.getUser(authuser.uid);
        if (user == null) {
          emit(AuthStateNeedDetails(
            email: authuser.email!,
          ));
          return;
        }
        emit(AuthStateLoggedIn(
          authuser: authuser,
          user: user,
          dbprovider: dbprovider,
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
        var authuser = await authProvider.loginWithEmail(email, password);
        if (authuser == null) {
          emit(AuthStateNeedLogin(
            email: email,
            password: password,
            error: 'Invalid email or password',
          ));
          return;
        }
        if (!(authuser.isVerified ?? false)) {
          emit(AuthStateNeedVerify(
            email: authuser.email!,
          ));
          return;
        }
        var user = await dbprovider.getUser(authuser.uid);
        if (user == null) {
          emit(AuthStateNeedDetails(
            email: authuser.email!,
          ));
          return;
        }
        emit(AuthStateLoggedIn(
          authuser: authuser,
          user: user,
          dbprovider: dbprovider,
        ));
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
    // on<AuthEventLoginAnonymously>((event, emit) async {
    //   emit(AuthStateNeedLogin(loading: 'Logging in...'));
    //   try {
    //     var user = await authProvider.loginAnnonymously();
    //     if (user == null) {
    //       emit(AuthStateNeedLogin(
    //         error: 'Error logging in anonymously',
    //       ));
    //       return;
    //     }
    //     emit(AuthStateLoggedIn(authuser: user));
    //   } on AuthException catch (e) {
    //     return emit(AuthStateNeedLogin(
    //       error: e.message,
    //     ));
    //   } catch (e) {
    //     return emit(AuthStateNeedLogin(
    //       error: e.toString(),
    //     ));
    //   }
    // });

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
      var authuser = authProvider.user;

      if (authuser == null) {
        return emit(AuthStateNeedLogin(error: 'User not found'));
      }

      emit(AuthStateNeedVerify(
          email: authuser.email!, loading: 'Verifying email...'));
      try {
        authuser = await authProvider.currentUser;
        if (authuser == null) {
          emit(AuthStateNeedLogin(error: 'User not found'));
          return;
        }
        if ((authuser.isVerified ?? false) == false) {
          emit(AuthStateNeedVerify(
              email: authuser.email!, error: 'Email not verified'));
          return;
        }
        var user = await dbprovider.getUser(authuser.uid);
        if (user == null) {
          emit(AuthStateNeedDetails(
            email: authuser.email!,
          ));
          return;
        }
        emit(AuthStateLoggedIn(
          authuser: authuser,
          user: user,
          dbprovider: dbprovider,
        ));
      } on AuthException catch (e) {
        emit(AuthStateNeedVerify(email: 'Unknown Email', error: e.message));
      }
    });

    on<AuthEventAddUserDetails>(
      (event, emit) {
        emit(AuthStateNeedDetails(
            email: event.email, loading: 'Adding user...'));
        try {
          var authuser = authProvider.user!;
          var user = User(
            uid: authProvider.user!.uid,
            name: event.name,
            email: authuser.email!,
            roll: event.rollNo,
            department: event.department,
            semester: event.semester,
            github: event.github,
            linkedin: event.linkedin,
          );

          dbprovider.createUser(user);
          emit(AuthStateLoggedIn(
            authuser: authuser,
            user: user,
            dbprovider: dbprovider,
          ));
        } on DBException catch (e) {
          emit(AuthStateNeedDetails(
            email: event.email,
            error: e.message,
          ));
        } catch (e) {
          emit(AuthStateNeedDetails(
            email: event.email,
            error: 'Something went wrong...',
          ));
        }
      },
    );
  }
}
