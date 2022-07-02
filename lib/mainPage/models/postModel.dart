import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? postId;
  final String? imageUrl;
  final String? postText;
  final DateTime? postDate;
  final int? likeAmount;
  final int? rainLevel;
  final String? posterUserId;
  final List<ReplyModel>? replyList;
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
      required this.replyList,
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
        replyList: data?["replyList"],
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
      if (replyList != null) "replyList": replyList,
      if (postCity != null) "postCity": postCity,
      if (postTown != null) "postTown": postTown
    };
  }
}

class ReplyModel {
  final String postId;
  final String replyId;
  final String replyContent;
  final DateTime replyDate;
  final int replyLikeAmount;
  final String replierUserId;
  ReplyModel(
      {required this.postId,
      required this.replyId,
      required this.replyContent,
      required this.replyDate,
      required this.replyLikeAmount,
      required this.replierUserId});
}
