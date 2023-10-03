import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eentrack/models/attendee_model.dart';

import '../../models/meeting_model.dart';
import '../../models/user_model.dart';
import 'db_exception.dart';
import 'db_model.dart';

class FirestoreDB implements DBModel {
  late final FirebaseFirestore _db;

  @override
  Future<void> init() async {
    _db = FirebaseFirestore.instance;
  }

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
          .doc(meeting.id)
          .set(meeting.toMap());
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
  Future<void> deleteMeeting(String uid, String mid) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(mid)
          .collection('attendees')
          .get()
          .then((value) async {
        for (DocumentSnapshot ds in value.docs) {
          await ds.reference.delete();
        }
      });
      await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(mid)
          .get()
          .then((value) async {
        await value.reference.delete();
      });
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<void> addAttendee(String uid, String mid, Attendee attendee) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(mid)
          .collection('attendees')
          .doc(attendee.uid)
          .set(attendee.toMap());
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<void> updateAttendee(String uid, String mid, Attendee attendee) async {
    try {
      var atd = await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(mid)
          .collection('attendees')
          .doc(attendee.uid)
          .get();

      if (!atd.exists) {
        throw DBException('Attendee does not exist');
      }
      await atd.reference.update(attendee.toMap());
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    }
  }

  @override
  Stream<List<Attendee>> getAttendees(String uid, String mid) {
    try {
      return _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(mid)
          .collection('attendees')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Attendee.fromMap(doc.data()))
            .toList();
      });
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<void> removeAttendee(String uid, String mid, Attendee attendee) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(mid)
          .collection('attendees')
          .doc(attendee.uid)
          .delete();
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<List<Attendee>> getAttendeesList(String uid, String mid) async {
    try {
      var snapshot = await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(mid)
          .collection('attendees')
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((doc) => Attendee.fromMap(doc.data()))
            .toList();
      } else {
        return [];
      }
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<bool> isAttendee(String uid, String mid, String aid) async {
    try {
      final doc = await _db
          .collection('users')
          .doc(uid)
          .collection('meetings')
          .doc(mid)
          .collection('attendees')
          .doc(aid)
          .get();
      return doc.exists;
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }
}
