class Stat {
  static const tableName = 'stat';
  static const columnId = '_id';
  static const columnName = 'username';
  static const columnScore = 'score';
  static const columnCategory = 'category';

  int id;
  String name;
  double score;
  String category;

  Stat();

  Stat.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    score = map[columnScore];
    category = map[columnCategory];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnName: name,
      columnScore: score,
      columnCategory: category,
    };
    if (id != null) map[columnId] = id;
    return map;
  }
}
