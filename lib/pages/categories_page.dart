import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:games_app/models/category.dart';
import 'package:games_app/pages/add_category_page.dart';
import 'package:games_app/services/game_stats_service.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with AutomaticKeepAliveClientMixin {
  GameStatsService service;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    service = Provider.of<GameStatsService>(context);
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddCategoryPage(),
            ),
          );
        },
      ),
      body: GridView.builder(
        itemCount: service.categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          Category category = service.categories[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Text(category.name),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
