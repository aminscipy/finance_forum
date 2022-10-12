import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  DocumentSnapshot<Map<String, dynamic>>? snapshot;
  bool snapEmpty = true;
  getData() async {
    await FirebaseFirestore.instance.disableNetwork();
    await FirebaseFirestore.instance.enableNetwork();
    final data = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .get();
    snapshot = data;
    snapEmpty = false;
    notifyListeners();
  }
}
