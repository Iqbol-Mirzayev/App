import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../utils/my_utils.dart';

class AuthViewModel {
  final FirebaseAuth _auth;

  AuthViewModel({required FirebaseAuth auth}) : _auth = auth;

  Future<void> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> updateDisplayName({
    required BuildContext context,
    required String displayName,
  }) async {
    try {
      await _auth.currentUser!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> updateEmail({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await _auth.currentUser!.updateEmail(email);
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> updatePassword({
    required BuildContext context,
    required String password,
  }) async {
    try {
      await _auth.currentUser!.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  //User get user => _auth.currentUser!;

  Stream<User?> authState() async* {
    yield* FirebaseAuth.instance.authStateChanges();
  }

  Stream<User?> get userInfoChanges => FirebaseAuth.instance.userChanges();

//
// // EMAIL VERIFICATION
// Future<void> sendEmailVerification(BuildContext context) async {
//   try {
//     _auth.currentUser!.sendEmailVerification();
//     MyUtils.showSnackBar(context, 'Email verification sent!');
//   } on FirebaseAuthException catch (e) {
//     MyUtils.showSnackBar(context, e.message!); // Display error message
//   }
// }
//
// // GOOGLE SIGN IN
// Future<void> signInWithGoogle(BuildContext context) async {
//   try {
//     if (kIsWeb) {
//       GoogleAuthProvider googleProvider = GoogleAuthProvider();
//       googleProvider
//           .addScope('https://www.googleapis.com/auth/contacts.readonly');
//       await _auth.signInWithPopup(googleProvider);
//     } else {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//
//       if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
//         // Create a new credential
//         final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth?.accessToken,
//           idToken: googleAuth?.idToken,
//         );
//         UserCredential userCredential =
//             await _auth.signInWithCredential(credential);
//       }
//     }
//   } on FirebaseAuthException catch (e) {
//     MyUtils.showSnackBar(context, e.message!); // Displaying the error message
//   }
// }
//
// // ANONYMOUS SIGN IN
// Future<void> signInAnonymously(BuildContext context) async {
//   try {
//     await _auth.signInAnonymously();
//   } on FirebaseAuthException catch (e) {
//     MyUtils.showSnackBar(context, e.message!); // Displaying the error message
//   }
// }
//
// // FACEBOOK SIGN IN
// Future<void> signInWithFacebook(BuildContext context) async {
//   try {
//     final LoginResult loginResult = await FacebookAuth.instance.login();
//
//     final OAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(loginResult.accessToken!.token);
//
//     await _auth.signInWithCredential(facebookAuthCredential);
//   } on FirebaseAuthException catch (e) {
//     MyUtils.showSnackBar(context, e.message!); // Displaying the error message
//   }
// }
//
// // PHONE SIGN IN
// Future<void> phoneSignIn(
//   BuildContext context,
//   String phoneNumber,
// ) async {
//   TextEditingController codeController = TextEditingController();
//   if (kIsWeb) {
//     ConfirmationResult result =
//         await _auth.signInWithPhoneNumber(phoneNumber);
//     // Diplay Dialog Box To accept OTP
//     showOTPDialog(
//       codeController: codeController,
//       context: context,
//       onPressed: () async {
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: result.verificationId,
//           smsCode: codeController.text.trim(),
//         );
//
//         await _auth.signInWithCredential(credential);
//         Navigator.of(context).pop(); // Remove the dialog box
//       },
//     );
//   } else {
//     // FOR ANDROID, IOS
//     await _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       //  Automatic handling of the SMS code
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // !!! works only on android !!!
//         await _auth.signInWithCredential(credential);
//       },
//       // Displays a message when verification fails
//       verificationFailed: (e) {
//         MyUtils.showSnackBar(context, e.message!);
//       },
//       // Displays a dialog box when OTP is sent
//       codeSent: ((String verificationId, int? resendToken) async {
//         showOTPDialog(
//           codeController: codeController,
//           context: context,
//           onPressed: () async {
//             PhoneAuthCredential credential = PhoneAuthProvider.credential(
//               verificationId: verificationId,
//               smsCode: codeController.text.trim(),
//             );
//
//             // !!! Works only on Android, iOS !!!
//             await _auth.signInWithCredential(credential);
//             Navigator.of(context).pop(); // Remove the dialog box
//           },
//         );
//       }),
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Auto-resolution timed out...
//       },
//     );
//   }
// }
}