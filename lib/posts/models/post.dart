import 'package:equatable/equatable.dart';

final class Post extends Equatable {
  const Post({
    required this.title,
    this.description,
    this.thumbnail,
    required this.subreddit,
    required this.score,
    required this.comments,
  });

  final String title;
  final String? description;
  final String? thumbnail;
  final String subreddit;
  final int score;
  final int comments;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json["title"],
      description: json["selftext"],
      thumbnail: json["thumbnail"],
      subreddit: json["subreddit_name_prefixed"],
      score: json["score"],
      comments: json["num_comments"],
    );
  }

  @override
  List<Object> get props => [title, subreddit, score, comments];
}