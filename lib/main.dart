import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_f/bloc/authbloc/auth_events.dart';
import 'package:project_f/bloc/authbloc/auth_state.dart';
import 'package:project_f/bloc/authbloc/authbloc.dart';
import 'package:project_f/screen/authscreens/loginscreen/login_screen.dart';
import 'package:project_f/screen/authscreens/registerscreen/register_screen.dart';
import 'package:project_f/screen/authscreens/verificationscreen/verification_screen.dart';
import 'package:project_f/screen/homescreen/home_screen.dart';
import 'package:project_f/screen/shared/loading_screen.dart';
import 'package:project_f/services/authservices/firebase_auth_service.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
          colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.cyan,
        brightness: Brightness.dark,
      )),
      home: BlocProvider(
        create: (context) => AuthBloc(FirebaseAuthService.instance),
        child: const AuthBlocHandle(),
      ), // No homescreen were there
    );
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
            return const HomeScreen();
          }
          if (state is AuthStateNeedLogin) {
            return LoginScreen(
              email: state.email,
              password: state.password,
              isLoading: state.loading != null,
              error: state.error,
            );
          }
          if (state is AuthStateNeedRegister) {
            return RegisterScreen(
              email: state.email,
              password: state.password,
              isLoading: state.loading != null,
              error: state.error,
            );
          }

          if (state is AuthStateNeedVerify) {
            return VerificationScreen(
              isLoading: state.loading != null,
              error: state.error,
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
