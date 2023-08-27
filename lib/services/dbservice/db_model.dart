import '../../models/meeting_model.dart';
import '../../models/user_model.dart';

abstract class DBModel {
  // User
  Future<User> createUser(User user);
  Future<User?> getUser(String uid);
  Future<User> updateUser(User user);
  Future<void> deleteUser(String uid);

  // Meetings
  Future<Meeting> createMeeting(String uid, Meeting meeting);
  Future<Meeting?> getMeeting(String uid, String mid);
  Stream<List<Meeting>> getMeetings(String uid);
  Future<Meeting> updateMeeting(String uid, Meeting meeting);
  Future<void> deleteMeeting(String uid, String mid);
}
