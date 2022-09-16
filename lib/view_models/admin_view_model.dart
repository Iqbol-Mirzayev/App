import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../utils/my_utils.dart';

class AdminsViewModel {
  final FirebaseFirestore _fireStore;

  AdminsViewModel({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  Future<bool> isAdmin({required String password}) async {
    try {
      var adminData = await _fireStore
          .collection('admins')
          .where("password", isEqualTo: password)
          .get();
      if (adminData.docs.isNotEmpty) {
        debugPrint("ADMIN TRUE");
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      MyUtils.getMyToast(message: e.message.toString());
    }
    return false;
  }
}