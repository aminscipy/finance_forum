import 'package:finance_forum/screens/complete_profile.dart';
import 'package:finance_forum/screens/otp_verify.dart';
import 'package:finance_forum/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'constants.dart';

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

  void verifyPhone() async {
    loading();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          getSnackBar('Invalid Number', 'Try with conutry code e.g. +91');
          Get.close(1);
        },
        codeSent: (verificationId, forceResendingToken) {
          verID = verificationId;
          forceResendingToken;
          Get.close(1);
          getSnackBar('OTP Sent!',
              'Please check your Inbox, will resent automatically after 60 seconds.');
          Get.to(() => const OtpVerify());
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 60));
    notifyListeners();
  }

  void verifyOtp() async {
    loading();
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verID, smsCode: otp);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.close(1);
      getSnackBar('Verified!', 'You are Logged in.');
      Get.to(() => const CompleteProfile());
    } on FirebaseAuthException {
      Get.close(1);
      getSnackBar('Invalid OTP!', 'Please try again.');
      Get.to(() => const Welcome());
    }
    notifyListeners();
  }

  Future<void> logOut() async {
    loading();
    await FirebaseAuth.instance.signOut();
    Get.close(1);
    getSnackBar('Logged out!', 'Login again.');
    Get.to(() => const Welcome());
    notifyListeners();
  }
}
