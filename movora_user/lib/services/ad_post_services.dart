import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movora/models/ads_model.dart';

class AdPostServices {
  final FirebaseFirestore _firestoreService = FirebaseFirestore.instance;

  Future<void> addPost(PostModel post) async {
    await _firestoreService
        .collection('post')
        .doc(post.postId)
        .set(post.toJson());
  }

  Stream<List<PostModel>> getAllPost() {
    return _firestoreService
        .collection('post')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PostModel.fromJson(doc.data()))
              .toList(),
        );
  }

  /// Fetch posts by specific user
  Stream<List<PostModel>> getUserPosts(String userId) {
    return _firestoreService
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PostModel.fromJson(doc.data()))
              .toList(),
        );
  }

  /// Update post (e.g. mark as sold)
  Future<void> updatePost(String postId, Map<String, dynamic> data) async {
    await _firestoreService.collection('posts').doc(postId).update(data);
  }

  /// Delete post
  Future<void> deletePost(String postId) async {
    await _firestoreService.collection('posts').doc(postId).delete();
  }
}
