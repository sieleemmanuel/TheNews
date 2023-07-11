import 'package:flutter/cupertino.dart';
import 'package:the_news/api/ApiService.dart';

import '../model/Article.dart';

class NewsProvider extends ChangeNotifier {
  final apiService = ApiService();
  bool isLoading = false;
  String error = "";
  int currentRequest = 0;
  List<Article> articles = [];
  List<Article> defaultArticles = [];
  List<Article> searchedArticles = [];
  List<Article> filteredArticles = [];

  Future<void> getArticles() async {
    try {
      error = "";
      currentRequest = 0;
      isLoading = true;
      notifyListeners();
      defaultArticles = await apiService.getArticles();
      articles = defaultArticles;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> getSearchedArticles(String query) async {
    try {
      error = "";
      currentRequest = 1;
      isLoading = true;
      notifyListeners();
      searchedArticles = await apiService.getSearchedArticles(query);
      articles = searchedArticles;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> getFilteredArticles(String category,
      String country,
      /*String language*/) async {
    try {
      error = "";
      currentRequest = 2;
      isLoading = true;
      notifyListeners();
      filteredArticles =
      await apiService.getFilteredArticles(category, country);
      articles = filteredArticles;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  resetRequest() {
    currentRequest = 0;
    notifyListeners();
  }

}
