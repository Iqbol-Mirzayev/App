import 'package:cloud_firestore/cloud_firestore.dart';

class AdminsViewModel {
  final FirebaseFirestore _fireStore;

  AdminsViewModel({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  Future<bool> isAdmin({required String password}) async {
    try {
      await _fireStore
          .collection('admins')
          .where("password", isEqualTo: password)
          .get();
      return true;
    } on FirebaseException catch (e) {}
    return false;
  }
}