import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/models/Comments/comment_model.dart';
import 'package:uuid/uuid.dart';

class CommentsController {
  static Future<void> addComment(String postId, CommentModel comment) async {
    final commentId = const Uuid().v4();
    try {
      await FirebaseContants.commentsCollection
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set(comment.toJson());
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<CommentModel>> getComments(String postId) async {
    List<CommentModel> comments = [];
    try {
      final commentsData = await FirebaseContants.commentsCollection
          .doc(postId)
          .collection('comments')
          .orderBy('createdAt', descending: true)
          .get();
      if (commentsData.docs.isEmpty) {
        return comments;
      } else {
        for (var comment in commentsData.docs) {
          comments.add(CommentModel.fromJson(comment.data()));
        }
        return comments;
      }
    } catch (error) {
      rethrow;
    }
  }
}
