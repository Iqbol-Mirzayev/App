import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../data/models/order/order_item.dart';
import '../data/models/products/product_item.dart';
import '../utils/my_utils.dart';

class OrderViewModel {
  final FirebaseFirestore _fireStore;

  OrderViewModel({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  Future<void> addOrder(
      {required BuildContext context,
      required OrderItem orderItem,
      required int allProductsCount}) async {
    try {
      var newOrder =
          await _fireStore.collection("orders").add(orderItem.toJson());
      await _fireStore.collection("orders").doc(newOrder.id).update({
        "order_id": newOrder.id,
      });
      await _fireStore.collection("products").doc(orderItem.productId).update({
        "count": allProductsCount - orderItem.count,
      });

      MyUtils.getMyToast(message: "Muvaffaqiyatli qo'shildi");
    } on FirebaseException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> updateOrder({
    required BuildContext context,
    required OrderItem orderItem,
    required String docId,
  }) async {
    try {
      await _fireStore
          .collection("orders")
          .doc(docId)
          .update(orderItem.toJson());
      MyUtils.getMyToast(message: "Muvaffaqiyatli update bo'ldi");
    } on FirebaseException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> updateOrderStatus({
    required String status,
    required String docId,
  }) async {
    try {
      await _fireStore
          .collection("orders")
          .doc(docId)
          .update({"order_status": status});
      MyUtils.getMyToast(message: "Status muvaffaqiyatli update bo'ldi");
    } on FirebaseException catch (e) {
      MyUtils.getMyToast(message:  e.message.toString());
    }
  }

  Future<void> cancelOrder({
    required BuildContext context,
    required OrderItem orderItem,
  }) async {
    try {
      //1
      await _fireStore.collection("orders").doc(orderItem.orderId).delete();
      //2
      var pr = await _fireStore
          .collection("products")
          .doc(orderItem.productId)
          .get();

      ProductItem productItem =
          ProductItem.fromJson(pr.data() as Map<String, dynamic>);
      //3
      await _fireStore.collection("products").doc(orderItem.productId).update({
        "count": productItem.count + orderItem.count,
      });

      MyUtils.getMyToast(message: "Muvaffaqiyatli cancel bo'ldi");
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
      MyUtils.getMyToast(message: "Muvaffaqiyatli o'chirildi");
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