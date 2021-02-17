import 'package:flutter/material.dart';
import 'package:games_app/models/category.dart';
import 'package:games_app/models/stat.dart';
import 'package:games_app/services/game_stats_service.dart';
import 'package:provider/provider.dart';

class AddStatPage extends StatefulWidget {
  @override
  _AddStatPageState createState() => _AddStatPageState();
}

class _AddStatPageState extends State<AddStatPage> {
  final _formKey = GlobalKey<FormState>();
  GameStatsService service;
  Stat stat = Stat();

  submitStat(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await service.createStat(stat);
      stat = Stat();
      _formKey.currentState.reset();
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Stat was added')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    service = Provider.of<GameStatsService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: stat.category,
                  hint: Text('Select a Game'),
                  onChanged: (val) {
                    setState(() {
                      stat.category = val;
                    });
                  },
                  validator: (val) =>
                      val == null ? 'Please select a game' : null,
                  items: service.categories
                      .map(
                        (category) => DropdownMenuItem(
                          child: Text(category.name),
                          value: category.name,
                        ),
                      )
                      .toList(),
                ),
                Divider(color: Colors.transparent),
                TextFormField(
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Please enter a valid username'
                      : null,
                  onSaved: (newValue) => stat.name = newValue,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                Divider(color: Colors.transparent),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || double.tryParse(value) == null
                          ? 'Please enter a valid score'
                          : null,
                  onSaved: (newValue) => stat.score = double.tryParse(newValue),
                  decoration: InputDecoration(labelText: 'Score'),
                ),
                Divider(color: Colors.transparent),
                FloatingActionButton.extended(
                  label: Text('SAVE'),
                  icon: Icon(Icons.save_outlined),
                  heroTag: 'stat',
                  onPressed: () {
                    submitStat(context);
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
