class PostModel {
  final String postId;
  final String imageUrl;
  final String postText;
  final DateTime postDate;
  final int likeAmount;
  final int rainLevel;
  final String posterUserId;
  final List<ReplyModel> replyList;
  PostModel(
      {required this.postId,
      required this.imageUrl,
      required this.postText,
      required this.postDate,
      required this.likeAmount,
      required this.rainLevel,
      required this.posterUserId,
      required this.replyList});
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
