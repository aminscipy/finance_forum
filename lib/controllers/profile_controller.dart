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
    try {
      await FirebaseFirestore.instance.disableNetwork();
      await FirebaseFirestore.instance.enableNetwork();
      final data = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .get();
      snapshot = data;
      snapEmpty = false;
      notifyListeners();
    } catch (e) {
      'error';
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  XFile? profileImage;

  Future profilePic() async {
    loading();
    try {
      profileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      Reference reference = storage.ref().child(
          "photos/profile pictures/${FirebaseAuth.instance.currentUser!.phoneNumber}");
      UploadTask uploadTask = reference.putFile((i.File(profileImage!.path)));
      String profileUrl = await uploadTask.snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .update({'profilePic': profileUrl});
      Get.close(1);
    } catch (e) {
      'image not selected';
      Get.close(1);
    }
    notifyListeners();
  }

  editProfile(context, hint, format) {
    String updatedValue = '';
    try {
      Get.defaultDialog(
        title: 'Update',
        backgroundColor: Colors.lightBlue,
        content: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              maxLength: 25,
              cursorColor: Colors.black,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: hint,
              ),
              keyboardType: format,
              onChanged: (value) {
                updatedValue = value;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () async {
                Get.close(1);
                loading();
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
                    .update({hint: updatedValue});
                Get.close(1);
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ))
        ]),
      );
    } catch (e) {
      'no changes made';
    }
    notifyListeners();
  }
}
