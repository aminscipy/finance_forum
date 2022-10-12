import 'package:finance_forum/views/complete_profile.dart';
import 'package:finance_forum/views/home.dart';
import 'package:finance_forum/views/otp_verify.dart';
import 'package:finance_forum/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends ChangeNotifier {
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
      var user = await FirebaseAuth.instance.signInWithCredential(credential);
      Get.close(1);
      if (user.additionalUserInfo!.isNewUser) {
        getSnackBar('Welcome!', 'Please complete your profile.');
        Get.to(() => const CompleteProfile());
      } else {
        getSnackBar('Verified!', 'You are Logged In.');
        Get.to(() => const Home());
      }
    } on FirebaseAuthException {
      Get.close(1);
      getSnackBar('Invalid OTP!', 'Please try again.');
      Get.to(() => const Welcome());
    }
    notifyListeners();
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.close(1);
      getSnackBar('Logged out!', 'Login again.');
      Get.to(() => const Welcome());
      notifyListeners();
    } catch (e) {
      Get.close(1);
      getSnackBar('Oops!', 'Something went wrong');
    }
  }

  Future<void> completProfile(
      {required String name,
      required String username,
      required String dob,
      required String gender,
      required String sebi}) async {
    loading();
    String? phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    if (name != '' && dob != '' && username != '' && gender != '') {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(phoneNumber)
          .set({
        'phoneNumber': phoneNumber,
        'username': username,
        'name': name,
        'sebi': sebi,
        'gender': gender,
        'dob': dob,
        'followers': [],
        'following': [],
      });
      Get.close(1);
      getSnackBar('You are all set!', 'Start exlporing or add your own post');
      Get.to(() => const Home());
    } else {
      Get.close(1);
      getSnackBar('Oops!', 'Please fill in required fields.');
    }
    notifyListeners();
  }
}

statePersist() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const Home();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        return const Welcome();
      });
}
