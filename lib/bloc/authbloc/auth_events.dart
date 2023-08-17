abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  AuthEventLogin({required this.email, required this.password});
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  AuthEventRegister({required this.email, required this.password});
}

class AuthEventLogout extends AuthEvent {}

class AuthEventLoginAnonymously extends AuthEvent {}

class AuthEventVerifyEmail extends AuthEvent {}

class AuthEventShowRegister extends AuthEvent {
  bool isLoading;
  String email;
  String password;
  AuthEventShowRegister({
    this.isLoading = false,
    this.email = '',
    this.password = '',
  });
}

class AuthEventShowLogin extends AuthEvent {
  bool isLoading;
  String email;
  String password;

  AuthEventShowLogin({
    this.isLoading = false,
    this.email = '',
    this.password = '',
  });
}

class AuthEventShowVerifyEmail extends AuthEvent {
	bool isLoading;
	AuthEventShowVerifyEmail({this.isLoading = false});
}
