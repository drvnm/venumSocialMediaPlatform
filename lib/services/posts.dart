import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/post.dart';

//TODO: fix all of this

class PostService {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      print(doc.id);
      return PostModel(
        id: doc.id,
        text: doc.data()['text'] ?? '',
        creator: doc.data()['creator'] ?? '',
        timestamp: doc.data()['timestamp'] ?? 0,
      );
    }).toList();
  }

  Future savePost(String text, uid) async {
    await instance.collection("posts").add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser.uid,
      'likes': 0,
      'comments': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
    await instance
        .collection("users")
        .doc(uid)
        .update({'posts': FieldValue.increment(1)});
  }

  Stream<List<PostModel>> getPostsByUser(uid) {
    return instance
        .collection('posts')
        .where('creator', isEqualTo: uid)
        .snapshots()
        .map(_postListFromSnapshot);
  }

  getFeedFromFollowing() {
    print("gets called");
    String id = FirebaseAuth.instance.currentUser.uid;
    instance
        .collection("following")
        .doc(id)
        .collection("users")
        .snapshots()
        .map((docs) {
      docs.docs.map((doc) {
        print('ttt');
      });
    });
    print("not called anymore");
  }
}
