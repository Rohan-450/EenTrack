import 'package:dynamic_color/dynamic_color.dart';
import 'package:eentrack/services/dbservice/firestore_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/authbloc/auth_events.dart';
import 'bloc/authbloc/auth_state.dart';
import 'bloc/authbloc/authbloc.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'screen/authscreens/loginscreen/login_screen.dart';
import 'screen/authscreens/registerscreen/register_screen.dart';
import 'screen/authscreens/verificationscreen/verification_screen.dart';
import 'screen/homescreen/home_screen.dart';
import 'screen/shared/loading_screen.dart';
import 'screen/userCredentialscreen/usercredential_screen.dart';
import 'services/authservices/firebase_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
      return MaterialApp(
        title: 'EenTrack',
        theme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
            colorScheme: darkDynamic ??
                ColorScheme.fromSeed(
                  seedColor: Colors.cyan,
                  brightness: Brightness.dark,
                )),
        home: BlocProvider(
          create: (context) =>
              AuthBloc(FirebaseAuthService.instance, FirestoreDB()),
          child: const AuthBlocHandle(),
        ), // No homescreen were there
      );
    });
  }
}

class AuthBlocHandle extends StatefulWidget {
  const AuthBlocHandle({super.key});

  @override
  State<AuthBlocHandle> createState() => _AuthBlocHandleState();
}

class _AuthBlocHandleState extends State<AuthBlocHandle> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateUninitialized) {
            BlocProvider.of<AuthBloc>(context).add(AuthEventInit());
            return const LoadingScreen();
          }
          if (state is AuthStateLoading) {
            return const LoadingScreen();
          }
          if (state is AuthStateLoggedIn) {
            return HomeScreen(
              isLoading: state.loading != null,
              error: state.error,
              user: state.user,
              dbprovider: state.dbprovider,
            );
          }
          if (state is AuthStateNeedLogin) {
            return LoginScreen(
              email: state.email,
              password: state.password,
              isLoading: state.loading,
              error: state.error,
            );
          }
          if (state is AuthStateNeedRegister) {
            return RegisterScreen(
              email: state.email,
              password: state.password,
              loading: state.loading,
              error: state.error,
            );
          }

          if (state is AuthStateNeedVerify) {
            return VerificationScreen(
              email: state.email,
              isLoading: state.loading != null,
              error: state.error,
            );
          }
          if (state is AuthStateNeedDetails) {
            return UserCredForm(
              email: state.email,
            );
          }

          return Scaffold(
            body: Center(
              child: Text('Unknown state: $state'),
            ),
          );
        },
        listener: (context, state) {});
  }
}
