import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_f/models/meeting_model.dart';
import 'package:project_f/models/user_model.dart';
import 'package:project_f/services/dbservice/db_model.dart';

import 'db_exception.dart';

class FirestoreDB implements DBModel {
  final String uid;
  FirestoreDB(this.uid);
  final _db = FirebaseFirestore.instance;

  @override
  Future<User> createUser(User user) async {
    try {
      await _db.collection('users').doc(uid).set(user.toMap());
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }

    return user;
  }

  @override
  Future<void> deleteUser(String uid) async {
    try {
      await _db.collection('users').doc(uid).delete();
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<User?> getUser(String uid) async {
    try {
      var snapshot = await _db.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return User.fromMap(snapshot.data()!);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<User> updateUser(User user) async {
    try {
      await _db.collection('users').doc(uid).update(user.toMap());
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
    return user;
  }

  // Meetings
  @override
  Future<Meeting> createMeeting(Meeting meeting) async {
    try {
      await _db.collection('meetings').doc(meeting.id).set(meeting.toMap());
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
    return meeting;
  }

  @override
  Future<Meeting> updateMeeting(Meeting meeting) async {
    try {
      await _db.collection('meetings').doc(meeting.id).update(meeting.toMap());
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
    return meeting;
  }

  @override
  Future<Meeting?> getMeeting(String id) async {
    try {
      var snapshot = await _db.collection('meetings').doc(id).get();
      if (snapshot.exists) {
        return Meeting.fromMap(snapshot.data()!);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Stream<List<Meeting>> getMeetings(String uid) {
    try {
      return _db
          .collection('meetings')
          .where('host', isEqualTo: uid)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Meeting.fromMap(doc.data())).toList());
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<void> deleteMeeting(String id) {
    try {
      return _db.collection('meetings').doc(id).delete();
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }
}
