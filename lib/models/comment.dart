import 'user.dart';

import '../models/thread.dart';
import '../utils/parse_time.dart';

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
  final CommentStats stats;
  final User sender;
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
    bool hasParentComment = json["reply_to"] is Map<String, dynamic>;
    return Comment(
      cid: json["cid"],
      content: json["content"],
      createTime: json["create_time"],
      replyto: hasParentComment
          ? Comment.fromjson(json["reply_to"])
          : null, //json["reply_to"] is a map
      stats: CommentStats.fromjson(json["stats"]),
      sender: User.fromjson(json["sender"]),
      status: json["status"],
    );
  }

  factory Comment.byUser(
      int id, String content, UserInfo sender, Comment? replyTo) {
    return Comment(
      cid: id,
      content: content,
      createTime: getCurrUnixTime(),
      replyto: replyTo,
      stats: CommentStats(like: 0, dislike: 0, reply: 0, me: 0),
      sender: User.fromInfo(sender),
      status: 0,
    );
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
      json["continuous"],
      Thread.fromJson(json["thread"]),
    );
  }
}
