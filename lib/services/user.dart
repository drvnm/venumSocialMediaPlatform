import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/utils.dart';

class UserService {
  UtilsService _utilsService = UtilsService();

  UserModel _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    return snapshot != null
        ? UserModel(
            id: snapshot.id,
            bio: snapshot.data()['bio'],
            email: snapshot.data()['email'],
            isVerified: snapshot.data()['isVerified'],
            name: snapshot.data()['name'],
            profileImgUrl: snapshot.data()['profile'],
          )
        : null;
  }

  Stream<UserModel> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot);
  }

  Future<void> updateProfile(
      File _profileImage, String name, String bio) async {
    String profileImageUrl = '';

    if (_profileImage != null) {
      profileImageUrl = await _utilsService.uploadFile(_profileImage,
          'user/profile/${FirebaseAuth.instance.currentUser.uid}/profile');
    }

    Map<String, Object> data = HashMap();
    if (name != '') data["name"] = name;
    if (profileImageUrl != '') data["profile"] = profileImageUrl;
    if (bio != '') data["bio"] = bio;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(data);
  }
}
