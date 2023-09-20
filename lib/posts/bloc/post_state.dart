part of 'post_bloc.dart';

enum PostStatus {initial, success, failure, loading}

final class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final bool isLoadingPosts;
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.isLoadingPosts = true,
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? isLoadingPosts,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      isLoadingPosts: isLoadingPosts ?? this.isLoadingPosts
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, posts, isLoadingPosts];
}