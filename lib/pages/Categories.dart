import 'package:flutter/material.dart';
import 'package:the_news/utils/Constants.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> categories = {
      "Business": "Business",
      "Entertainment": "Entertainment",
      "General": "General",
      "Health": "Health",
      "Science": "https://unsplash.com/photos/K8AzGcMJbLI",
      "Sports": "Sports",
      "Technology": "Technology"
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Categories"),
      ),
      body: GridView.builder(
          itemCount: Constants.categories.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(Constants.categories.values.elementAt(index)),
            );
          }),
    );
  }
}
