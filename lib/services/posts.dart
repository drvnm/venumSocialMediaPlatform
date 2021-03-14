import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/post.dart';

class PostService {
  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
        id: doc.id,
        text: doc.data()['text'] ?? '',
        creator: doc.data()['creator'] ?? '',
        timestamp: doc.data()['timestamp'] ?? 0,
      );
    }).toList();
  }

  List<PostModel> _postListFromDocs( snapshot) {
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
    await FirebaseFirestore.instance.collection("posts").add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser.uid,
      'likes': 0,
      'comments': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({'posts': FieldValue.increment(1)});
  }

  Stream<List<PostModel>> getPostsByUser(uid) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('creator', isEqualTo: uid)
        .snapshots()
        .map(_postListFromSnapshot);
  }

   _getPostsByUsers(QuerySnapshot snapshot) {
    // voor elk document
   return snapshot.docs.map((doc) async  {
     print(doc.id);
      var docs = await FirebaseFirestore.instance
          .collection('posts')
          .where("creator", isEqualTo: doc.id)
          .get();
       return docs.docs.map(_postListFromDocs).toList();
    }).toList();
  }

  Stream<List<List<PostModel>>> getPostsFromFollowingUsers() {
    var docs = FirebaseFirestore.instance
        .collection('following')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("users")
        .snapshots()
        .map(_getPostsByUsers);
    print(docs);
  }
}
