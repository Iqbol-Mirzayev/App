// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// class ChatViewModel {
//   final FirebaseFirestore _fireStore;

//   ChatViewModel({required FirebaseFirestore fireStore})
//       : _fireStore = fireStore;

//   Future<void> sendMessage({
//     required MessageItem messageItem,
//   }) async {
//     try {
//       var newMessage =
//           await _fireStore.collection("messages").add(messageItem.toJson());
//       await _fireStore
//           .collection("messages")
//           .doc(newMessage.id)
//           .update({"messageId": newMessage.id});
//     } on FirebaseException catch (e) {
//       debugPrint(e.message);
//     }
//   }

//   Stream<List<MessageItem>> getMessages() =>
//       _fireStore.collection('messages').orderBy("created_at").snapshots().map(
//             (snapshot) => snapshot.docs
//             .map((doc) => MessageItem.fromJson(doc.data()))
//             .toList(),
//       );
// }