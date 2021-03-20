import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/group.dart';
import 'package:social_app/models/message.dart';
import 'package:social_app/models/user.dart';

class GroupService {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  Future<void> addGroup(String username, String groupName) async {
    var result = await instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();

    String id = result.docs[0].id;
    print("-----------\nId is: " + id);
    instance.collection("chats").add({
      "users": [FirebaseAuth.instance.currentUser.uid, id],
      "createdAt": Timestamp.now(),
      "groupName": groupName,
    });
  }

  List<GroupModel> _getGroupModel(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var data = doc.data();
      return GroupModel(groupName: data['groupName'], id: doc.id);
    }).toList();
  }

  Stream<List<GroupModel>> getGroupsFromId() {
    return instance
        .collection("chats")
        .where('users', arrayContains: FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map(_getGroupModel);
  }

  Future<void> addMessage(String id, String text, UserModel user) async {
    if (user != null) {
      print(user?.isVerified);
      print(user?.email);
      await instance.collection("chats").doc(id).collection("messages").add({
        "creator": FirebaseAuth.instance.currentUser.uid,
        "text": text,
        "timestamp": Timestamp.now(),
        "isVerified": user.isVerified ?? false,
        "username": user.name ?? "NULL",
        "profileImageUrl": user.profileImgUrl ??
            "https://inlandfutures.org/wp-content/uploads/2019/12/thumbpreview-grey-avatar-designer.jp",
      });
    }
  }

  List<MessageModel> _getMessageModel(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var data = doc.data();
      return doc != null
          ? MessageModel(
              isVerified: data['isVerified'],
              profileImgUrl: data['profileImageUrl'],
              name: data['username'],
              creator: data['creator'],
              text: data['text'] ?? "NULL",
              timestamp: data['timestamp'],
            )
          : null;
    }).toList();
  }

  Stream<List<MessageModel>> getMessagesByGroup(String id) {
    return instance
        .collection("chats")
        .doc(id)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .limit(50)
        .snapshots()
        .map(_getMessageModel);
  }
}
