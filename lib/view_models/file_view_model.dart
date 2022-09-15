import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../utils/my_utils.dart';

class FileViewModel {
  Future<void> uploadUserImage(
    PlatformFile pickedFile,
      BuildContext context,
  ) async {
    try {
      MyUtils.showLoader(context);
      String storagePath = "files/images/${pickedFile.name}";
      var ref = FirebaseStorage.instance.ref().child(storagePath);
      var task =  await ref.putFile(File(pickedFile.path!));
      String downloadUrl = await task.ref.getDownloadURL();
      var auth = FirebaseAuth.instance.currentUser;
      await auth!.updatePhotoURL(downloadUrl);
      Navigator.pop(context);
    } on FirebaseException catch (error) {
      MyUtils.getMyToast(message: error.message.toString());
    }
  }
}
