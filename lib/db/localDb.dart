import '../model/Article.dart';

class LocalDb {
  Future<List<Article>> getBookmarkedArticles() async {
    try {} catch (e) {
      throw Exception(e);
    }
    throw Exception("Unknown error occurred");
  }
}
