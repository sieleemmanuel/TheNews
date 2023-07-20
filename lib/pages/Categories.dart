import 'package:flutter/material.dart';
import 'package:the_news/components/CategoryTile.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> categories = {
      "Business": "assets/business.jpg",
      "Entertainment": "assets/entertainment.jpg",
      "General": "assets/general.jpg",
      "Health": "assets/health.jpg",
      "Science": "assets/science.jpg",
      "Sports": "assets/sports.jpg",
      "Technology": "assets/technology.jpg"
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Categories"),
      ),
      body: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
          itemBuilder: (context, index) {
            var category = categories.keys.elementAt(index);
            return categoryListTile(context, category, categories[category]!);
          }),
    );
  }
}
