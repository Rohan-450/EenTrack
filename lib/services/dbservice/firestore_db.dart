import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/meeting_model.dart';
import '../../models/user_model.dart';
import 'db_exception.dart';
import 'db_model.dart';

class FirestoreDB implements DBModel {
  final _db = FirebaseFirestore.instance;

  @override
  Future<User> createUser(User user) async {
    try {
      await _db.collection('users').doc(user.uid).set(user.toMap());
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
      await _db.collection('users').doc(user.uid).update(user.toMap());
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
    return user;
  }

  // Meetings
  @override
  Future<Meeting> createMeeting(String uid, Meeting meeting) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .add(meeting.toMap());
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
    return meeting;
  }

  @override
  Future<Meeting> updateMeeting(String uid, Meeting meeting) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(meeting.id)
          .update(meeting.toMap());
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
    return meeting;
  }

  @override
  Future<Meeting?> getMeeting(String uid, String mid) async {
    try {
      var snapshot = await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(mid)
          .get();
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
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Meeting.fromMap(doc.data())).toList();
      });
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<void> deleteMeeting(String uid, String mid) async{
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(mid)
          .delete();
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }
}
