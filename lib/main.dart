import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_f/bloc/authbloc/authbloc.dart';
import 'package:project_f/screen/homescreen/home_screen.dart';
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

class AuthBlocHandle extends StatelessWidget {
  const AuthBlocHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        builder: (context, state) {
          return const Placeholder();
        },
        listener: (context, state) {});
  }
}
