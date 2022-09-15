import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shopping/data/models/card/order_item.dart';
import 'package:shopping/utils/my_utils.dart';

class OrderViewModel {
  final FirebaseFirestore _fireStore;

  OrderViewModel({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  Future<void> addOrder({
    required BuildContext context,
    required OrderItem orderItem,
  }) async {
    try {
      await _fireStore.collection("orders").doc().set(orderItem.toJson());
      MyUtils.showSnackBar(context, "Muvaffaqiyatli qo'shildi");
    } on FirebaseException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> updateOrder(
      {required BuildContext context,
      required OrderItem orderItem,
      required String docId}) async {
    try {
      await _fireStore
          .collection("orders")
          .doc(docId)
          .update(orderItem.toJson());
      MyUtils.showSnackBar(context, "Muvaffaqiyatli update bo'ldi");
    } on FirebaseException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> deleteOrder({
    required BuildContext context,
    required String docId,
  }) async {
    try {
      await _fireStore.collection("orders").doc(docId).delete();
      MyUtils.showSnackBar(context, "Muvaffaqiyatli o'chirildi");
    } on FirebaseException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Stream<List<OrderItem>> getAllOrders() =>
      _fireStore.collection('orders').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => OrderItem.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<OrderItem>> getAllUserOrders({required String userId}) =>
      _fireStore
          .collection('orders')
          .where("user_id", isEqualTo: userId)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => OrderItem.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getOrdersForAdmin() => _fireStore.collection('orders').snapshots().map(
            (snapshot) => snapshot.docs,
          );

  Future<void> updateUser({required String imagePath}) {
    CollectionReference users = _fireStore.collection('users');
    return rootBundle
        .load('assets/images/sample.jpg')
        .then((bytes) => bytes.buffer.asUint8List())
        .then((avatar) {
          return users.doc('ABC123').update({'info.avatar': Blob(avatar)});
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}