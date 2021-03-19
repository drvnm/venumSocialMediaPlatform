import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/user.dart';

import 'package:social_app/services/utils.dart';

class UserService {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  UtilsService _utilsService = UtilsService();

  Future<bool> isFollowing(id) async {
    var doc = await instance
        .collection("followers")
        .doc(id)
        .collection("usersThatFollow")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    return doc.exists;
  }

  UserModel _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    return snapshot != null
        ? UserModel(
            id: snapshot.id,
            bio: snapshot.data()['bio'],
            email: snapshot.data()['email'],
            followers: snapshot.data()['followers'],
            following: snapshot.data()['following'],
            isVerified: snapshot.data()['isVerified'],
            name: snapshot.data()['name'] ?? 'NULL',
            profileImgUrl: snapshot.data()['profile'] ??
                "https://inlandfutures.org/wp-content/uploads/2019/12/thumbpreview-grey-avatar-designer.jpg",
            postAmount: snapshot.data()['posts'],
          )
        : null;
  }

  UserModel _getUserPreviewModel(QueryDocumentSnapshot snapshot) {
    print(snapshot.id);
    return UserModel(
      id: snapshot.id,
      bio: snapshot.data()['bio'],
      email: snapshot.data()['email'],
      followers: snapshot.data()['followers'],
      following: snapshot.data()['following'],
      isVerified: snapshot.data()['isVerified'],
      name: snapshot.data()['name'] ?? 'NULL',
      profileImgUrl: snapshot.data()['profile'] ??
          "https://inlandfutures.org/wp-content/uploads/2019/12/thumbpreview-grey-avatar-designer.jpg",
      postAmount: snapshot.data()['posts'],
    );
  }

  Future<void> followUser(id) async {
    String loggedInUser = FirebaseAuth.instance.currentUser.uid;
    await instance
        .collection("followers")
        .doc(id)
        .collection("usersThatFollow")
        .doc(loggedInUser)
        .set({});

    await instance
        .collection("users")
        .doc(loggedInUser)
        .update({'following': FieldValue.increment(1)});

    await instance
        .collection("users")
        .doc(id)
        .update({'followers': FieldValue.increment(1)});
    await instance
        .collection("following")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("users")
        .doc(id)
        .set({});
  }

  Future<void> unfollowUser(id) async {
    String loggedInUser = FirebaseAuth.instance.currentUser.uid;
    await instance
        .collection("followers")
        .doc(id)
        .collection("usersThatFollow")
        .doc(loggedInUser)
        .delete();

    await instance
        .collection("users")
        .doc(loggedInUser)
        .update({'following': FieldValue.increment(-1)});

    await instance
        .collection("users")
        .doc(id)
        .update({'followers': FieldValue.increment(-1)});
    await instance
        .collection("following")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("users")
        .doc(id)
        .delete();
  }

  Stream<UserModel> getUserInfo(uid) {
    return instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot);
  }

  Future<List<UserModel>> getUsersFromName(String name) async {
    var docs = await instance
        .collection("users")
        .orderBy("name")
        .startAt([name]).endAt([name + '\uf8ff']).get();

    var list = docs.docs.map(_getUserPreviewModel).toList();
    print(list[0].id);
    return list;
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

    await instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(data);
  }
}
