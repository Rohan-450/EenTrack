import 'dart:io';

abstract class StorageModel {
  Future<File> getProfile(String uid);
  Future<String> uploadProfile(File image);
  Future<void> deleteProfile(String uid);
}
