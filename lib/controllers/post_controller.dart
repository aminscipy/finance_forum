import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_forum/constants.dart';
import 'package:finance_forum/controllers/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends ChangeNotifier {
  String symbol = '';
  String opinion = '';
  Future<void> post() async {
    loading();
    String? phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    if (symbol != '' && opinion != '') {
      await FirebaseFirestore.instance.collection('posts').add({
        'owner': phoneNumber,
        'symbol': symbol,
        'opinion': opinion,
        'price when posted': null,
        'likes': [],
        'dislikes': [],
        'comments': [],
        'share': [],
        "timestamp": FieldValue.serverTimestamp()
      }).then((documentSnapshot) => FirebaseFirestore.instance
              .collection('users')
              .doc(phoneNumber)
              .update({
            'posts': FieldValue.arrayUnion([documentSnapshot.id])
          }));
      Get.close(1);
      getSnackBar('Done!', 'Your post is uploaded.');
    } else {
      Get.close(1);
      getSnackBar('Sorry!', 'stock symbol and opinion cannot be empty.');
    }
    notifyListeners();
  }

  int postListLength = 0;
  DocumentSnapshot<Map<String, dynamic>>? snapshot;
  bool snapEmpty = true;
  getPostData({index}) async {
    postListLength =
        await FirebaseFirestore.instance.collection('posts').snapshots().length;
    print(postListLength);
    await FirebaseFirestore.instance.disableNetwork();
    await FirebaseFirestore.instance.enableNetwork();
    final data =
        await FirebaseFirestore.instance.collection("posts").doc(index).get();
    snapshot = data;
    snapEmpty = false;
    notifyListeners();
  }
}
