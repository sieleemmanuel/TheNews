import 'package:flutter/material.dart';
import 'package:the_news/model/Article.dart';

import '../pages/Detail.dart';

Widget articleListTile(BuildContext context, Article article) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Details(
                  article: article,
                )),
      );
    },
    child: Container(
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 3.0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage != null
                ? Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(article.urlToImage!),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12.0)),
                  )
                : Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/placeholder.png'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              article.source!.name!,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              article.title!,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        )),
  );
}
