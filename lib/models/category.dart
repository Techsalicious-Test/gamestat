class Category {
  static const tableName = 'category';
  static const columnId = '_id';
  static const columnName = 'name';

  int id;
  String name;
  Category();

  Category.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {columnName: name};
    if (id != null) map[columnId] = id;
    return map;
  }
}
