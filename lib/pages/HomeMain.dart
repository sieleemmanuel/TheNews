import 'package:flutter/material.dart';
import 'package:the_news/pages/Bookmarks.dart';
import 'package:the_news/pages/Categories.dart';
import 'package:the_news/pages/Home.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int selectedItem = 0;

  //New
  static const List<Widget> _pages = [Home(), Bookmarks(), Categories()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: "Bookmark",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: "Categories",
            )
          ],
          currentIndex: selectedItem,
          onTap: (index) {
            setState(() {
              selectedItem = index;
            });
          },
        ),
        body: _pages.elementAt(selectedItem));
  }
}
