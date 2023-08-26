class Meeting {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  Meeting({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  Meeting copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
  }) {
    return Meeting(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }
}
