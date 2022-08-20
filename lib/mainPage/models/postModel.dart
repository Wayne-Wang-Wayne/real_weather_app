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
  final String? locCode;
  String? posterName = "";
  String? posterImageUrl = "";
  int? posterLikedTimes = 0;
  int? posterPostTimes = 0;
  int? posterExp = 0;
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
      required this.locCode,
      this.posterName,
      this.posterImageUrl,
      this.posterLikedTimes,
      this.posterPostTimes,
      this.posterExp,
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
        locCode: data?["locCode"],
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
      if (locCode != null) "locCode": locCode,
      if (likedPeopleList != null) "likedPeopleList": likedPeopleList
    };
  }
}

class ReplyListModel {
  final List<dynamic>? replyList;

  ReplyListModel({required this.replyList});

  factory ReplyListModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return ReplyListModel(replyList: data?["replyList"]);
  }

  Map<String, dynamic> toFirestore() {
    return {if (replyList != null) "replyList": replyList};
  }
}

class ReplyItemModel {
  final String replierId;
  final String replyContent;
  final int replyDateTimestamp;
  final String replierName;
  final int replierExp;
  final String replierAvatarUrl;
  ReplyItemModel(
      {required this.replierId,
      required this.replyContent,
      required this.replyDateTimestamp,
      required this.replierName,
      required this.replierExp,
      required this.replierAvatarUrl});

  static ReplyItemModel convertToModel(Map<String, dynamic> reply) {
    return ReplyItemModel(
        replierId: reply["replierId"],
        replyContent: reply["replyContent"],
        replyDateTimestamp: reply["replyDateTimestamp"],
        replierName: reply["replierName"],
        replierExp: reply["replierExp"],
        replierAvatarUrl: reply["replierAvatarUrl"]);
  }
}
