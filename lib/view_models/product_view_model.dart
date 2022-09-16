import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../data/models/products/product_item.dart';
import '../utils/my_utils.dart';

class ProductViewModel {
  final FirebaseFirestore _fireStore;

  ProductViewModel({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  Future<void> addProduct({
    required BuildContext context,
    required ProductItem productItem,
  }) async {
    try {
      var newProduct =
          await _fireStore.collection("products").add(productItem.toJson());
      await _fireStore
          .collection("products")
          .doc(newProduct.id)
          .update({"product_id": newProduct.id});
      MyUtils.getMyToast(message: "Muvaffaqiyatli qo'shildi");
    } on FirebaseException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> deleteProduct({
    required BuildContext context,
    required String docId,
  }) async {
    try {
      await _fireStore.collection("products").doc(docId).delete();
      MyUtils.getMyToast(message: "Muvaffaqiyatli o'chirildi");
    } on FirebaseException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Stream<List<ProductItem>> getProducts() =>
      _fireStore.collection('products').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => ProductItem.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<ProductItem>> getCategoryProducts({required String categoryId}) =>
      _fireStore
          .collection('products')
          .where("category_id", isEqualTo: categoryId)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => ProductItem.fromJson(doc.data()))
                .toList(),
          );
}