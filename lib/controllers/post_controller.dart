import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_forum/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PostController extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String symbol = '';
  String opinion = '';
  DateTime time = DateTime.now();
  String? phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
  Future<void> post() async {
    loading();
    final data = await firestore.collection("users").doc(phoneNumber).get();
    if (symbol != '' && opinion != '') {
      await firestore.collection('posts').add({
        'name': data.get('name'),
        'username': data.get('username'),
        'profile pic': data.get('profilePic'),
        'owner': phoneNumber,
        'symbol': symbol,
        'opinion': opinion,
        'price when posted': null,
        'likes': [],
        'dislikes': [],
        'comments': [],
        'share': [],
        "timestamp": DateFormat.yMMMd().add_jm().format(time)
      }).then((documentSnapshot) =>
          firestore.collection('users').doc(phoneNumber).update({
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

  bool isLiked = false;
  bool isDisliked = false;
  bool isCommented = false;
  bool isShared = false;
  bool isFollowing = false;

  liked(index) {
    if (!isLiked) {
      firestore.collection('posts').doc(index).update({
        'likes': FieldValue.arrayUnion([phoneNumber])
      });
      isLiked = true;
    } else {
      firestore.collection('posts').doc(index).update({
        'likes': FieldValue.arrayRemove([phoneNumber])
      });
      isLiked = false;
    }
    notifyListeners();
  }

  disliked(index) {
    if (!isDisliked) {
      firestore.collection('posts').doc(index).update({
        'dislikes': FieldValue.arrayUnion([phoneNumber])
      });
      isDisliked = true;
    } else {
      firestore.collection('posts').doc(index).update({
        'dislikes': FieldValue.arrayRemove([phoneNumber])
      });
      isDisliked = false;
    }
    notifyListeners();
  }

  following(owner) {
    if (!isFollowing) {
      firestore.collection('users').doc(phoneNumber).update({
        'followers': FieldValue.arrayUnion([owner])
      });
      isFollowing = true;
      print('hello');
    } else {
      firestore.collection('users').doc(phoneNumber).update({
        'followers': FieldValue.arrayRemove([owner])
      });
      isFollowing = false;
      print(owner);
    }
    notifyListeners();
  }
}
