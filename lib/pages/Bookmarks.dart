import 'package:flutter/material.dart';
import 'package:the_news/components/ArticleListTile.dart';

import '../db/localDb.dart';
import '../model/Article.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Bookmarks"),
      ),
      body: FutureBuilder(
          future: LocalDb().getBookmarkedArticles(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Article>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              List<Article>? articles = snapshot.data;
              return ListView.builder(
                  itemBuilder: (context, index) =>
                      articleListTile(context, articles![index]));
            }
            return const Center(
              child: Text("No bookmarks found"),
            );
          }),
    );
  }
}
