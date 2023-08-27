class Attendee {
  String uid;
  String name;
  String department;
  String roll;
  String semester;
  String? github;
  String? linkedin;

  Attendee({
    required this.uid,
    required this.name,
    required this.department,
    required this.roll,
    required this.semester,
    this.github,
    this.linkedin,
  });

  factory Attendee.fromMap(Map<String, dynamic> json) {
    return Attendee(
      uid: json['uid'],
      name: json['name'],
      department: json['department'],
      roll: json['rollNo'],
      semester: json['semester'],
      github: json['github'],
      linkedin: json['linkedin'],
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'department': department,
        'rollNo': roll,
        'semester': semester,
        'github': github,
        'linkedin': linkedin,
      };
}
