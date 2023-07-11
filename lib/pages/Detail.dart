import 'package:flutter/material.dart';
import 'package:the_news/db/localDb.dart';
import 'package:the_news/model/Article.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  final Article article;

  const Details({Key? key, required this.article}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool _isBookMarked = false;

  _checkBookmark() {
    setState(() {
      _isBookMarked = LocalDb().isArticleBookmarked(widget.article);
    });
  }

  @override
  void initState() {
    super.initState();
    _checkBookmark();
    debugPrint("Is bookmarked: $_isBookMarked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                LocalDb().insertArticle(widget.article);
                _checkBookmark();
              });
            },
            icon: _isBookMarked
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.bookmark_outline),
          ),
        ],
      ),
      body: ListView(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: widget.article.urlToImage != null
                      ? BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.article.urlToImage!),
                              fit: BoxFit.cover))
                      : const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/placeholder.png"),
                              fit: BoxFit.cover))),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  widget.article.title != null
                      ? widget.article.title!
                      : "Missing title",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  widget.article.description != null
                      ? widget.article.description!
                      : "Description not found!!",
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    "More",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  _launchUrl(widget.article.url!);
                },
              )
            ],
          ),
        ),
      ]),
    );
  }

  _launchUrl(String articleUrl) async {
    final url = Uri.parse(articleUrl);
    if (!await launchUrl(url)) {
      throw Exception("Failed to load $articleUrl");
    }
  }
}
