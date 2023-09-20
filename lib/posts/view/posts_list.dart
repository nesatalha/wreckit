import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wreckit_lib/posts/bloc/post_bloc.dart';
import 'package:wreckit_lib/posts/widgets/loading_spinner.dart';
import 'package:wreckit_lib/posts/widgets/post_list_item.dart';
import 'package:http/http.dart' as http;

class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(
              child: Text("error fetching posts"),
            );
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(
                child: Text('no posts'),
              );
            }
            return Stack(
              children: [
                SafeArea(
                  bottom: false,
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return index >= state.posts.length
                                ? const LoadingSpinner()
                                : PostListItem(post: state.posts[index]);
                          }, childCount: state.posts.length
                      ),
                    ),
                    ]
                  ),
                ),
/*
                ListView.builder(
                  itemBuilder: (context, index) {
                    return index >= state.posts.length
                        ? const LoadingSpinner()
                        : PostListItem(post: state.posts[index]);
                  },
                ),
*/
                state.isLoadingPosts
                    ? Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: AbsorbPointer(
                          absorbing: true,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: const Center(
                              child: LoadingSpinner(),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          case PostStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case PostStatus.loading:
            return Stack(
              children: [
                SafeArea(
                  bottom: false,
                  child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return index >= state.posts.length
                                    ? const LoadingSpinner()
                                    : PostListItem(post: state.posts[index]);
                              }, childCount: state.posts.length
                          ),
                        ),
                      ]
                  ),
                ),
/*
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return index >= state.posts.length
                          ? const LoadingSpinner()
                          : PostListItem(post: state.posts[index]);
                    },
                  ),
*/
                state.isLoadingPosts
                    ? Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AbsorbPointer(
                    absorbing: true,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: const Center(
                        child: LoadingSpinner(),
                      ),
                    ),
                  ),
                )
                    : Container(),
              ],
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isTop) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isTop {
    if (!_scrollController.hasClients) return false;
    final minScroll = _scrollController.position.minScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll <= (minScroll - 60);
  }
}
