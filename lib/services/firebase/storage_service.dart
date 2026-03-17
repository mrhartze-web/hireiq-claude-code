import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadCV(String uid, Uint8List fileBytes, String fileName) async {
    final ref = _storage.ref().child('cvs/$uid/$fileName');
    final task = await ref.putData(
      fileBytes,
      SettableMetadata(contentType: 'application/pdf'),
    );
    return await task.ref.getDownloadURL();
  }

  Future<String> uploadProfilePhoto(String uid, Uint8List fileBytes) async {
    final ref = _storage.ref().child('profile_photos/$uid/photo.jpg');
    final task = await ref.putData(
      fileBytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return await task.ref.getDownloadURL();
  }

  Future<String> uploadCompanyLogo(String uid, Uint8List fileBytes) async {
    final ref = _storage.ref().child('company_logos/$uid/logo.jpg');
    final task = await ref.putData(
      fileBytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return await task.ref.getDownloadURL();
  }

  Future<void> deleteFile(String storagePath) async =>
      await _storage.ref().child(storagePath).delete();
}
