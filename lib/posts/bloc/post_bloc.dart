import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:wreckit_lib/posts/models/post.dart';
import 'package:http/http.dart' as http;

part 'post_event.dart';
part 'post_state.dart';


const _initialPosts = 10;
const throttleDuration = Duration(milliseconds: 1000);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration)
    );
  }
  
  final http.Client httpClient;

  Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emit) async {
    try {
      emit(state.copyWith(isLoadingPosts: true, status: PostStatus.loading));
      if(state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        log("inital count => ${posts.length}");
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            isLoadingPosts: false
          ),
        );
      }
      final posts = await _fetchPosts(state.posts.length + _initialPosts);
      log("posts count => ${posts.length}");
      emit(state.copyWith(
        status: PostStatus.success,
        posts: posts,
        isLoadingPosts: false
      ),
      );
    } catch (e) {
      log("error => ${e.toString()}");
      emit(state.copyWith(status: PostStatus.failure, isLoadingPosts:  false));
    }
  }
  
  Future<List<Post>> _fetchPosts([int count = _initialPosts]) async {
    try {
      final res = await httpClient.get(
          Uri.parse("https://www.reddit.com/r/flutterdev/top.json?count=20")
      );
      if(res.statusCode == 200) {
        final resJson = jsonDecode(res.body);
        return (resJson["data"]["children"] as List).map((e) => Post.fromJson(e["data"])).toList();
      }
      throw Exception("error fetching");
    } catch (e) {
      log("error fetch : ${e.toString()}");
      return [];
    }

  }
}
