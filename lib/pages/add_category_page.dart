import 'package:flutter/material.dart';
import 'package:games_app/models/category.dart';
import 'package:games_app/services/game_stats_service.dart';
import 'package:provider/provider.dart';

class AddCategoryPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    GameStatsService service = Provider.of<GameStatsService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(labelText: 'Game'),
              ),
              Divider(color: Colors.transparent),
              FloatingActionButton.extended(
                label: Text('SAVE'),
                icon: Icon(Icons.save_outlined),
                onPressed: () async {
                  if (controller.text == null ||
                      controller.text.trim().isEmpty) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a valid Game Name!'),
                      ),
                    );

                    return;
                  }
                  if (service.categories.any((element) =>
                      element.name.toUpperCase() ==
                      controller.text.trim().toUpperCase())) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Game Already Exists!'),
                      ),
                    );
                    return;
                  }
                  Category category = Category();
                  category.name = controller.text.trim();
                  await service.createCategory(category);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${category.name} was Added'),
                    ),
                  );
                  controller.clear();
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
