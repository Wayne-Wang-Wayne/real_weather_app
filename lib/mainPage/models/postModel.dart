import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? postId;
  final String? imageUrl;
  final String? postText;
  final DateTime? postDate;
  final int? likeAmount;
  final int? rainLevel;
  final String? posterUserId;
  final String? postCity;
  final String? postTown;
  PostModel(
      {required this.postId,
      required this.imageUrl,
      required this.postText,
      required this.postDate,
      required this.likeAmount,
      required this.rainLevel,
      required this.posterUserId,
      required this.postCity,
      required this.postTown});

  factory PostModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return PostModel(
        postId: data?["postId"],
        imageUrl: data?["imageUrl"],
        postText: data?["postText"],
        postDate: data?["postDate"],
        likeAmount: data?["likeAmount"],
        rainLevel: data?["rainLevel"],
        posterUserId: data?["posterUserId"],
        postCity: data?["postCity"],
        postTown: data?["postTown"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (postId != null) "postId": postId,
      if (imageUrl != null) "imageUrl": imageUrl,
      if (postText != null) "postText": postText,
      if (postDate != null) "postDate": postDate,
      if (likeAmount != null) "likeAmount": likeAmount,
      if (rainLevel != null) "rainLevel": rainLevel,
      if (posterUserId != null) "posterUserId": posterUserId,
      if (postCity != null) "postCity": postCity,
      if (postTown != null) "postTown": postTown
    };
  }
}

class ReplyModel {
  final String? postId;
  final String? replyContent;
  final DateTime? replyDate;
  final int? replyLikeAmount;
  final String? replierUserId;
  ReplyModel(
      {required this.postId,
      required this.replyContent,
      required this.replyDate,
      required this.replyLikeAmount,
      required this.replierUserId});

  factory ReplyModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return ReplyModel(
      postId: data?["postId"],
      replyContent: data?["replyContent"],
      replyDate: data?["replyDate"],
      replyLikeAmount: data?["replyLikeAmount"],
      replierUserId: data?["replierUserId"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (postId != null) "postId": postId,
      if (replyContent != null) "replyContent": replyContent,
      if (replyDate != null) "replyDate": replyDate,
      if (replyLikeAmount != null) "replyLikeAmount": replyLikeAmount,
      if (replierUserId != null) "replierUserId": replierUserId,
    };
  }
}
