import 'model.dart';

class User implements DataModel {
  final String uid;
  String name;
  String? photoUrl;
  String department;
  String roll;
  String semester;
  String email;
  String linkedin;
  String github;

  User({
    required this.uid,
    required this.name,
    this.photoUrl,
    required this.department,
    required this.roll,
    required this.semester,
    required this.email,
    required this.linkedin,
    required this.github,
  });

  User copyWith({
    String? uid,
    String? name,
    String? photoUrl,
    String? department,
    String? rollNo,
    String? semester,
    String? email,
    String? linkedin,
    String? github,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      department: department ?? this.department,
      roll: rollNo ?? this.roll,
      semester: semester ?? this.semester,
      email: email ?? this.email,
      linkedin: linkedin ?? this.linkedin,
      github: github ?? this.github,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'photoUrl': photoUrl,
      'department': department,
      'rollNo': roll,
      'semester': semester,
      'email': email,
      'linkedin': linkedin,
      'github': github,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      name: map['name'],
      photoUrl: map['photoUrl'],
      department: map['department'],
      roll: map['rollNo'],
      semester: map['semester'],
      email: map['email'],
      linkedin: map['linkedin'],
      github: map['github'],
    );
  }
}
