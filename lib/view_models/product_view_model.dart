import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping/data/models/products/product_item.dart';
import 'package:shopping/utils/my_utils.dart';

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

  Stream<List<ProductItem>> getProducts() =>
      _fireStore.collection('products').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => ProductItem.fromJson(doc.data()))
                .toList(),
          );
}