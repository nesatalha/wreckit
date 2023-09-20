import 'package:flutter/material.dart';

import 'posts/view/posts_page.dart';

class App extends MaterialApp {
  App({super.key}) : super(home: const PostsPage(),theme: ThemeData.dark(), debugShowCheckedModeBanner: false);
}