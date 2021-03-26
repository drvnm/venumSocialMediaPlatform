import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/post.dart';


//TODO: fix all of this 


class PostService {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  List<String> getPostsFromIds(QuerySnapshot snapshot) {
    // returns 
    print("Getting ids");
    return snapshot.docs.map((doc) {
      return doc.id;
    }).toList();
   
  }

   Stream<List<String>> getFeedFromFollowing() {
     print("ye");
    var x = instance
        .collection("following")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("users")
        .snapshots()
        .map(getPostsFromIds);
      return x;
  }

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

  List<PostModel> _postListFromDocs(snapshot) {
    return snapshot.docs.map((doc) {
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
}
