import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? postId;
  final String? imageUrl;
  final String? postText;
  final int? postDateTimeStamp;
  final int? rainLevel;
  final String? posterUserId;
  final String? postCity;
  final String? postTown;
  String? posterName = "";
  String? posterImageUrl = "";
  String? posterTitle = "";
  List<dynamic>? likedPeopleList = [];
  PostModel(
      {required this.postId,
      required this.imageUrl,
      required this.postText,
      required this.postDateTimeStamp,
      required this.rainLevel,
      required this.posterUserId,
      required this.postCity,
      required this.postTown,
      this.posterName,
      this.posterImageUrl,
      this.posterTitle,
      required this.likedPeopleList});

  factory PostModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return PostModel(
        postId: data?["postId"],
        imageUrl: data?["imageUrl"],
        postText: data?["postText"],
        postDateTimeStamp: data?["postDateTimeStamp"],
        rainLevel: data?["rainLevel"],
        posterUserId: data?["posterUserId"],
        postCity: data?["postCity"],
        postTown: data?["postTown"],
        likedPeopleList: data?["likedPeopleList"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (postId != null) "postId": postId,
      if (imageUrl != null) "imageUrl": imageUrl,
      if (postText != null) "postText": postText,
      if (postDateTimeStamp != null) "postDateTimeStamp": postDateTimeStamp,
      if (rainLevel != null) "rainLevel": rainLevel,
      if (posterUserId != null) "posterUserId": posterUserId,
      if (postCity != null) "postCity": postCity,
      if (postTown != null) "postTown": postTown,
      if (likedPeopleList != null) "likedPeopleList": likedPeopleList
    };
  }
}

class ReplyModel {
  final String? postId;
  final String? replyContent;
  final int? replyDateTimeStamp;
  final int? replyLikeAmount;
  final String? replierUserId;
  ReplyModel(
      {required this.postId,
      required this.replyContent,
      required this.replyDateTimeStamp,
      required this.replyLikeAmount,
      required this.replierUserId});

  factory ReplyModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return ReplyModel(
      postId: data?["postId"],
      replyContent: data?["replyContent"],
      replyDateTimeStamp: data?["replyDateTimeStamp"],
      replyLikeAmount: data?["replyLikeAmount"],
      replierUserId: data?["replierUserId"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (postId != null) "postId": postId,
      if (replyContent != null) "replyContent": replyContent,
      if (replyDateTimeStamp != null) "replyDateTimeStamp": replyDateTimeStamp,
      if (replyLikeAmount != null) "replyLikeAmount": replyLikeAmount,
      if (replierUserId != null) "replierUserId": replierUserId,
    };
  }
}
