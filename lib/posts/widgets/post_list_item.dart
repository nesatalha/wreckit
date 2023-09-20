import 'package:flutter/material.dart';
import 'package:wreckit_lib/posts/models/post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.subreddit,
                        style: textTheme.labelSmall,
                      ),
                      const SizedBox(height: 2,),
                      Text(
                        post.title,
                        style: textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        post.description ?? "",
                        style: textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                  Container(
                    width: (post.thumbnail != null && (post.thumbnail!.contains("http"))) ?  60 : 0,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image:(post.thumbnail != null && (post.thumbnail!.contains("http"))) ? DecorationImage(image: NetworkImage(post.thumbnail!,), fit: BoxFit.cover) : null,

                    ),
                  )
              ],
            ),
            const SizedBox(height: 6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.upload_outlined, color: Theme.of(context).hintColor,),
                    SizedBox(width: 12,),
                    Text(post.score.toString()),
                    SizedBox(width: 12,),
                    Icon(Icons.download_outlined, color: Theme.of(context).hintColor,)
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.chat_bubble_outline, color: Theme.of(context).hintColor,),
                    const SizedBox(width: 12,),
                    Text(post.comments.toString()),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.file_upload_outlined, color: Theme.of(context).hintColor,),
                    const SizedBox(width: 12,),
                    Text("Share"),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}