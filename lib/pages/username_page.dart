import 'package:flutter/material.dart';
import 'package:games_app/game_stat.dart';
import 'package:games_app/pages/root_page.dart';

class UsernamePage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please provide your username'),
      ),
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              Divider(color: Colors.transparent),
              FloatingActionButton.extended(
                onPressed: () async {
                  if (controller.text == null ||
                      controller.text.trim().isEmpty) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a valid Name!'),
                      ),
                    );
                    return;
                  }
                  await GameStat.preferences.setString(
                    GameStat.usernamePref,
                    controller.text.trim(),
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => RootPage(),
                    ),
                  );
                },
                label: Text('SUBMIT'),
              )
            ],
          ),
        );
      }),
    );
  }
}
