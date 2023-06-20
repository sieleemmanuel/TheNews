import 'package:flutter/material.dart';
import 'package:the_news/utils/Constants.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Categories"),
      ),
      body: ListView.builder(
          itemCount: Constants.categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(Constants.categories.values.elementAt(index)),
            );
          }),
    );
  }
}
