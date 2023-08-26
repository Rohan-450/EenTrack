import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'storage_exception.dart';
import 'storage_model.dart';

class FirebaseStorageService implements StorageModel {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> deleteProfile(String path) {
    try {
      var ref = _firebaseStorage.ref().child('profile').child(path);
      return ref.delete();
    } catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future<File> getProfile(String uid) async {
    try {
      var ref = _firebaseStorage.ref().child('profile').child(uid);
      var bytes = await ref.getData();
      var file = File('${Directory.systemTemp.path}/$uid.jpg');
      await file.writeAsBytes(bytes!);
      return file;
    } catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future<String> uploadProfile(File image) async {
    try {
      var ref = _firebaseStorage.ref().child('profile').child('image');
      var uploadTask = ref.putFile(image);
      var url = await (await uploadTask).ref.getDownloadURL();
      return url;
    } catch (e) {
      throw StorageException(e.toString());
    }
  }
}
