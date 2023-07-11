import 'package:hive/hive.dart';

import '../model/Article.dart';

class LocalDb {
  late Box hiveBox;
  late List bookmarks;
  final bookmarksDb = getBookmarksDb();

  initBox() async {
    hiveBox = await Hive.openBox("bookmarks");
  }

  Future insertArticle(Article article) async {
    if (!isArticleBookmarked(article)) {
      bookmarksDb.add(article);
    } else {
      removeArticle(article);
    }
  }

  removeArticle(Article article) {
    var articleToDelete =
        bookmarksDb.values.where((element) => element.url == article.url).first;
    articleToDelete.delete();
  }

  isArticleBookmarked(Article article) {
    return bookmarksDb.values
        .where((element) => element.url == article.url)
        .isNotEmpty;
  }

  getBookmarkedArticles() {
    return hiveBox.get("bookmarks") ?? [];
  }

  static Box<Article> getBookmarksDb() => Hive.box<Article>("bookmarks");
}
