import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/group.dart';

class GroupService {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  Future<void> addGroup(String username, String groupName) async {
    var result = await instance
        .collection("users")
        .where("name", isEqualTo: username)
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
}
