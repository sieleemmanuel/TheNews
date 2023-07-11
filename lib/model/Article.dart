import 'package:hive/hive.dart';

import 'Source.dart';

part 'Article.g.dart';

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(1)
  Source? source;
  @HiveField(2)
  String? author;
  @HiveField(3)
  String? title;
  @HiveField(4)
  String? description;
  @HiveField(5)
  String? url;
  @HiveField(6)
  String? urlToImage;
  @HiveField(0)
  String? publishedAt;
  @HiveField(7)
  String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}
