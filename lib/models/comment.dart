import 'dart:convert';
import '../models/thread.dart';

class CommentStats {
  int like;
  int dislike;
  int reply;
  int me;

  CommentStats(
      {required this.like,
      required this.dislike,
      required this.reply,
      required this.me});

  factory CommentStats.fromjson(Map<String, dynamic> json) {
    return CommentStats(
        like: json["like"],
        dislike: json["dislike"],
        reply: json["reply"],
        me: json["me"]);
  }
}

class Comment {
  final int cid;
  final String content;
  final int createTime;
  final Comment? replyto;
  CommentStats stats;
  final Sender sender;
  final int status;
  Comment(
      {required this.cid,
      required this.content,
      required this.createTime,
      required this.replyto,
      required this.stats,
      required this.sender,
      required this.status});
  factory Comment.fromjson(Map<String, dynamic> json) {
    return Comment(
        cid: json["cid"],
        content: json["content"],
        createTime: json["createTime"],
        replyto: Comment.fromjson(json["reply_to"]), //json["reply_to"] is a map
        stats: CommentStats.fromjson(json["stats"]),
        sender: Sender.fromjson(json["sender"]),
        status: json["status"]);
  }
}

class ThreadDetailModel {
  final List<Comment> commentsList;
  final String continuous;
  final Thread? threadDetail;

  ThreadDetailModel(this.commentsList, this.continuous, this.threadDetail);

  factory ThreadDetailModel.fromJson(Map<String, dynamic> json) {
    List<Comment> comments =
        (json["comments"] as Iterable).map((t) => Comment.fromjson(t)).toList();

    return ThreadDetailModel(
        comments,
        json["continuous"], //json["has_next"] is map, b is <List>Comments
        Thread.fromJson(json["thread_detail"])); //json["thread_detail"] is map
  }
}

class CommentReplies {
  final int cid;
  final String content;
  final int createTime;
  CommentStats stats;
  final Sender sender;
  final int status;

  CommentReplies(
      {required this.cid,
      required this.content,
      required this.createTime,
      required this.stats,
      required this.sender,
      required this.status});

  factory CommentReplies.fromjson(Map<String, dynamic> json) {
    return CommentReplies(
        cid: json["cid"],
        content: json["content"],
        createTime: json["create_time"],
        stats: CommentStats.fromjson(json["stats"]),
        sender: Sender.fromjson(json["sender"]),
        status: json["status"]);
  }
}

class CommentDetail {
  Comment comment;
  List<CommentReplies>? replies;

  CommentDetail(this.comment, this.replies);

  factory CommentDetail.fromjson(Map<String, dynamic> json) {
    dynamic a = json[
        "replies"]; //json["replies"] return List , all index element is map(dynamic variable)
    List<CommentReplies> b = [];
    for (int i = 0; i < a.length; i++) {
      b.add(CommentReplies.fromjson(a[i]));
    }
    return CommentDetail(Comment.fromjson(json["comment"]), b);
  }
}
