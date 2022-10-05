import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Controller extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  ThemeMode changeTheme() {
    notifyListeners();
    if (mode == ThemeMode.light) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }
    return mode;
  }

  String verID = '';
  String phoneNumber = '';
  String otp = '';
  bool codeSent = false;

  void verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          const snackBar = SnackBar(content: Text('OTP sent!'));
          const ScaffoldMessenger(child: snackBar);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          codeSent = true;
          verID = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verID = verificationId;
        },
        timeout: const Duration(seconds: 60));
    notifyListeners();
  }

  void verifyOtp() async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verID, smsCode: otp);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('logged in');
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    notifyListeners();
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    print('logged out');
    notifyListeners();
  }
}
