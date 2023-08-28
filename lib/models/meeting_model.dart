import 'model.dart';

class Meeting implements DataModel{
  final String id;
  final String hostid;
  final String title;
  final String description;
  final DateTime date;

  Meeting({
    required this.id,
    required this.hostid,
    required this.title,
    required this.description,
    required this.date,
  });

  Meeting copyWith({
    String? id,
    String? hostid,
    String? title,
    String? description,
    DateTime? date,
  }) {
    return Meeting(
      id: id ?? this.id,
      hostid: hostid ?? this.hostid,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hostid': hostid,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      id: map['id'],
      hostid: map['hostid'],
      title: map['title'],
      description: map['description'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }
  
  @override
  Map<String, dynamic> exportData() {
    // TODO: implement exportData
    throw UnimplementedError();
  }
}
