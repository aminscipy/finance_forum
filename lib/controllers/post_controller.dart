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
  Future<void> post() async {
    loading();
    DocumentSnapshot data = await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .get();
    if (symbol != '' && opinion != '') {
      await firestore.collection('posts').add({
        'name': data.get('name'),
        'username': data.get('username'),
        'profile pic': data.get('profilePic'),
        'owner': FirebaseAuth.instance.currentUser!.phoneNumber,
        'symbol': symbol,
        'opinion': opinion,
        'price when posted': null,
        'likes': [],
        'dislikes': [],
        'comments': [],
        'share': [],
        "timestamp": DateFormat.yMMMd().add_jm().format(DateTime.now())
      }).then((documentSnapshot) => firestore
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
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

  bool isLiked = false;
  bool isDisliked = false;
  bool isCommented = false;
  bool isShared = false;
  bool isFollowing = false;
  bool isFollower = false;

  liked(index) {
    if (!isLiked) {
      firestore.collection('posts').doc(index).update({
        'likes': FieldValue.arrayUnion(
            [FirebaseAuth.instance.currentUser!.phoneNumber])
      });
      isLiked = true;
    } else {
      firestore.collection('posts').doc(index).update({
        'likes': FieldValue.arrayRemove(
            [FirebaseAuth.instance.currentUser!.phoneNumber])
      });
      isLiked = false;
    }
    notifyListeners();
  }

  disliked(index) {
    if (!isDisliked) {
      firestore.collection('posts').doc(index).update({
        'dislikes': FieldValue.arrayUnion(
            [FirebaseAuth.instance.currentUser!.phoneNumber])
      });
      isDisliked = true;
    } else {
      firestore.collection('posts').doc(index).update({
        'dislikes': FieldValue.arrayRemove(
            [FirebaseAuth.instance.currentUser!.phoneNumber])
      });
      isDisliked = false;
    }
    notifyListeners();
  }

  following(owner) {
    if (!isFollowing) {
      firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .update({
        'following': FieldValue.arrayUnion([owner])
      });
      isFollowing = true;
    } else {
      firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .update({
        'following': FieldValue.arrayRemove([owner])
      });
      isFollowing = false;
    }
    notifyListeners();
  }

  followers(owner) {
    if (!isFollower) {
      firestore.collection('users').doc(owner).update({
        'followers': FieldValue.arrayUnion(
            [FirebaseAuth.instance.currentUser!.phoneNumber])
      });
      isFollower = true;
    } else {
      firestore.collection('users').doc(owner).update({
        'followers': FieldValue.arrayRemove(
            [FirebaseAuth.instance.currentUser!.phoneNumber])
      });
      isFollower = false;
    }
    notifyListeners();
  }
}
