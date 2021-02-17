import 'package:flutter/material.dart';
import 'package:games_app/game_stat.dart';
import 'package:games_app/pages/categories_page.dart';
import 'package:games_app/pages/stat_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  PageController pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
    );
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String username = GameStat.preferences.getString(GameStat.usernamePref);
    return Scaffold(
      appBar: AppBar(
        title: Text(username ?? ''),
      ),
      body: PageView(
        controller: pageController,
        children: [
          StatPage(),
          CategoriesPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Categories',
          ),
        ],
      ),
    );
  }
}
