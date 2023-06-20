import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:the_news/model/Article.dart';

class ApiService {
  final baseUrl = "newsapi.org";

  Future<List<Article>> getArticles() async {
    final queryParameters = {
      'country': 'us',
      'category': 'technology',
      'apiKey': 'f3b159be49d14c819c2f3bcab4e93849'
    };
    var url = Uri.https(baseUrl, "/v2/top-headlines", queryParameters);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception("Failed to get News");
    }
  }

  Future<List<Article>> getSearchedArticles(String query) async {
    try {
      final queryParameters = {
        'q': query.trimRight().toLowerCase(),
        'apiKey': 'f3b159be49d14c819c2f3bcab4e93849'
      };
      var searchUrl = Uri.https(baseUrl, "/v2/everything", queryParameters);
      var response = await http.get(searchUrl);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List<dynamic> body = json['articles'];
        List<Article> articles =
            body.map((dynamic item) => Article.fromJson(item)).toList();
        return articles;
      } else {
        throw Exception("Failed to get News");
      }
    } on SocketException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Article>> getFilteredArticles(
    String category,
    String country,
    /*String language*/
  ) async {
    try {
      final queryParameters = {
        'category': category,
        'country': country,
        //'language': language,
        'apiKey': 'f3b159be49d14c819c2f3bcab4e93849'
      };
      var filterUrl = Uri.https(baseUrl, "/v2/top-headlines", queryParameters);
      var response = await http.get(filterUrl);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List<dynamic> body = json['articles'];
        List<Article> articles =
            body.map((dynamic item) => Article.fromJson(item)).toList();
        return articles;
      }
    } on SocketException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
    throw Exception("Unknown error occurred");
  }
}
