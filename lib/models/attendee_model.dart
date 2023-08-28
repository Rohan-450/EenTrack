import 'package:eentrack/models/model.dart';

class Attendee implements DataModel {
  String uid;
  String name;
  String department;
  String roll;
  String semester;
  String email;
  String github;
  DateTime? addedOn;
  DateTime? leftOn;
  String linkedin;

  Attendee({
    required this.uid,
    required this.name,
    required this.department,
    required this.roll,
    required this.semester,
    required this.email,
    this.addedOn,
    this.leftOn,
    required this.github,
    required this.linkedin,
  });

  factory Attendee.fromMap(Map<String, dynamic> json) {
    return Attendee(
      uid: json['uid'],
      name: json['name'],
      department: json['department'],
      roll: json['rollNo'],
      semester: json['semester'],
      email: json['email'],
      addedOn: json['addedOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['addedOn'])
          : null,
      leftOn: json['leftOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['leftOn'])
          : null,
      github: json['github'],
      linkedin: json['linkedin'],
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'department': department,
        'rollNo': roll,
        'semester': semester,
        'email': email,
        'addedOn': addedOn?.millisecondsSinceEpoch,
        'leftOn': leftOn?.millisecondsSinceEpoch,
        'github': github,
        'linkedin': linkedin,
      };
}
