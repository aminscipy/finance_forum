import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_forum/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as i;

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

  FirebaseStorage storage = FirebaseStorage.instance;
  XFile? profileImage;
  String profileUrl = '';

  Future profilePic() async {
    loading();
    try {
      profileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      Reference reference = storage.ref().child(
          "photos/profile pictures/${FirebaseAuth.instance.currentUser!.phoneNumber}");
      UploadTask uploadTask = reference.putFile((i.File(profileImage!.path)));
      String location = await uploadTask.snapshot.ref.getDownloadURL();
      profileUrl = location;
      Get.close(1);
    } catch (e) {
      'image not selected';
      Get.close(1);
    }
    notifyListeners();
  }
}
