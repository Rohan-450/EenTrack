import 'package:project_f/models/meeting_model.dart';
import 'package:project_f/models/user_model.dart';

abstract class DBModel {
  // User
  Future<User> createUser(User user);
  Future<User?> getUser(String uid);
  Future<User> updateUser(User user);
  Future<void> deleteUser(String uid);

  // Meetings
  Future<Meeting> createMeeting(Meeting meeting);
  Future<Meeting?> getMeeting(String id);
  Stream<List<Meeting>> getMeetings(String uid);
  Future<Meeting> updateMeeting(Meeting meeting);
  Future<void> deleteMeeting(String id);
}