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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image:(post.thumbnail != null || post.thumbnail != 'self') ? DecorationImage(image: NetworkImage(post.thumbnail!), fit: BoxFit.cover) : null,

              ),
            )
          ],
        ),
      ),
    );
    return Material(
      child: ListTile(
        leading: Text('${post.title}', style: textTheme.bodySmall),
        title: Text(post.description ?? ""),
        isThreeLine: true,
        subtitle: Text(post.description ?? ""),
        dense: true,
      ),
    );
  }
}