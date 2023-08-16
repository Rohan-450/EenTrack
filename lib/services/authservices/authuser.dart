class AuthUser {
  String uid;
  String? email;
  bool? isVerified;

  AuthUser({
    required this.uid,
    this.email,
    this.isVerified,
  });
}
