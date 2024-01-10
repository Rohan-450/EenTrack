import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eentrack/models/attendee_model.dart';
import 'package:eentrack/models/model_consts.dart' as model_consts;

import '../../models/meeting_model.dart';
import '../../models/user_model.dart';
import 'db_exception.dart';
import 'db_model.dart';
import 'db_consts.dart' as db_consts;

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
  Future<List<User>> getUsers(List<String> uids) async {
    try {
      var futures = uids.map((e) => getUser(e));
      var users = await Future.wait(futures);
      return users.whereType<User>().toList();
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
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
          .collection(db_consts.meetings)
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
          .collection(db_consts.meetings)
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
      var snapshot = await _db.collection(db_consts.meetings).doc(mid).get();
      if (snapshot.exists) {
        return Meeting.fromMap(snapshot.data()!, uid);
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
          .collection(db_consts.meetings)
          .orderBy(model_consts.date, descending: true)
          .where(model_consts.hostid, isEqualTo: uid)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Meeting.fromMap(doc.data(), uid))
            .toList();
      });
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    } on Exception catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Stream<List<Meeting>> getCoHostedMeetings(String uid) {
    try {
      return _db
          .collection(db_consts.meetings)
          .where(model_consts.coHosts, arrayContains: uid)
          .orderBy(model_consts.date, descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Meeting.fromMap(doc.data(), uid))
            .toList();
      });
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    }
  }

  @override
  Future<void> deleteMeeting(String uid, String mid) async {
    try {
      var attendees = await getAttendeesList(uid, mid);
      var futures = attendees.map((e) => removeAttendee(uid, mid, e));
      await Future.wait(futures);
      await _db.collection(db_consts.meetings).doc(mid).delete();
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
          .collection(db_consts.meetings)
          .doc(mid)
          .collection(db_consts.attendee)
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
          .collection(db_consts.meetings)
          .doc(mid)
          .collection(db_consts.attendee)
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
          .collection(db_consts.meetings)
          .doc(mid)
          .collection(db_consts.attendee)
          .orderBy(model_consts.date, descending: true)
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
  Stream<List<Attendee>> getAddedAttendees(String uid, String mid) {
    try {
      return _db
          .collection(db_consts.meetings)
          .doc(mid)
          .collection(db_consts.attendee)
          .where(model_consts.addedOn, isNull: false)
          .orderBy(model_consts.addedOn, descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Attendee.fromMap(doc.data()))
            .toList();
      });
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    }
  }

  @override
  Stream<List<Attendee>> getLeftAttendees(String uid, String mid) {
    try {
      return _db
          .collection(db_consts.meetings)
          .doc(mid)
          .collection(db_consts.attendee)
          .where(model_consts.leftOn, isNull: false)
          .orderBy(model_consts.leftOn, descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Attendee.fromMap(doc.data()))
            .toList();
      });
    } on FirebaseException catch (e) {
      throw DBException(e.message ?? 'Unknown error');
    }
  }

  @override
  Future<void> removeAttendee(String uid, String mid, Attendee attendee) async {
    try {
      await _db
          .collection(db_consts.meetings)
          .doc(mid)
          .collection(db_consts.attendee)
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
          .collection(db_consts.meetings)
          .doc(mid)
          .collection(db_consts.attendee)
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
          .collection(db_consts.meetings)
          .doc(mid)
          .collection(db_consts.attendee)
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
