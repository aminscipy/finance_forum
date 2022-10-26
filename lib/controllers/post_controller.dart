import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_forum/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io' as i;
import 'package:uuid/uuid.dart';

class PostController extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String symbol = '';
  String opinion = '';
  String postPic = '';
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
        'symbol': symbol.capitalize,
        'opinion': opinion.capitalizeFirst,
        'postPic': postPic,
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
      postPic = '';
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

  FirebaseStorage storage = FirebaseStorage.instance;
  XFile? postImage;
  var uuid = const Uuid();

  postPicture() async {
    loading();
    try {
      postImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      Reference reference = storage.ref().child(
          "photos/post pictures/${FirebaseAuth.instance.currentUser!.phoneNumber}/${uuid.v4()}");
      UploadTask uploadTask = reference.putFile((i.File(postImage!.path)));
      postPic = await (await uploadTask).ref.getDownloadURL();
      getSnackBar('Done!', 'Your chart snap is added to post');
      Get.close(1);
    } catch (e) {
      'image not selected';
      Get.close(1);
    }
    notifyListeners();
  }
}
