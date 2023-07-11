import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:the_news/db/localDb.dart';

import '../components/ArticleListTile.dart';
import '../model/Article.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  late List<Article> bookmarkList;

  Future<List<Article>> getBookmarks() async {
    var box = await Hive.openBox("bookmarks");
    bookmarkList = box.get("bookmarks") ?? [];
    return bookmarkList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("News Bookmarks"),
        ),
        body: ValueListenableBuilder<Box<Article>>(
          valueListenable: LocalDb.getBookmarksDb().listenable(),
          builder: (context, db, _) {
            final bookmarks = db.values.toList().cast<Article>();
            return ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (context, index) =>
                    articleListTile(context, bookmarks[index]));
          },
        )
        /*FutureBuilder(
          future: getBookmarks(),
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
          }),*/
        );
  }
}
