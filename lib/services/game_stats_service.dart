import 'package:flutter/cupertino.dart';
import 'package:games_app/models/category.dart';
import 'package:games_app/models/stat.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GameStatsService extends ChangeNotifier {
  List<Category> categories = [];
  Map<String, List<Stat>> stats = {};
  Database db;

  Future<void> openDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'stats.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE ${Category.tableName} (${Category.columnId} INTEGER PRIMARY KEY, ${Category.columnName} TEXT)',
        );
        await db.execute(
          'CREATE TABLE ${Stat.tableName} (${Stat.columnId} INTEGER PRIMARY KEY, ${Stat.columnName} TEXT, ${Stat.columnScore} REAL, ${Stat.columnCategory} TEXT)',
        );
      },
    );
  }

  Future<void> getCategories() async {
    var res = await db.query(Category.tableName);
    res.forEach((map) {
      categories.add(Category.fromMap(map));
    });
    notifyListeners();
  }

  Future<void> createCategory(Category category) async {
    category.id = await db.insert(Category.tableName, category.toMap());
    categories.add(category);
    notifyListeners();
  }

  Future<void> getStats() async {
    for (Category category in categories) {
      var res = await db.query(
        Stat.tableName,
        where: '${Stat.columnCategory} = ?',
        whereArgs: [category.name],
        orderBy: '${Stat.columnScore} DESC',
      );
      if (stats[category.name] == null) stats[category.name] = [];
      res.forEach((map) {
        stats[category.name].add(Stat.fromMap(map));
      });
      notifyListeners();
    }
  }

  Future<void> createStat(Stat stat) async {
    stat.id = await db.insert(Stat.tableName, stat.toMap());
    if (stats[stat.category] == null) stats[stat.category] = [];
    stats[stat.category].add(stat);
    stats[stat.category].sort((a, b) => a.score > b.score ? -1 : 1);
    notifyListeners();
  }
}
