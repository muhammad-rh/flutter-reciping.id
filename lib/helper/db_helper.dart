import 'package:flutter_mini_project/models/create_recipe.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  static late Database _database;

  final String tableName = 'tableRecipe';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnThumb = 'thumb';
  final String columnServings = 'servings';
  final String columnTimes = 'times';
  final String columnDificulty = 'dificulty';
  final String columnDatePublished = 'datePublished';
  final String columnDesc = 'desc';
  final List<String> columnIngredient = ['ingredient'];
  final List<String> columnStep = ['step'];

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'createRecipe.db'),
      onCreate: _onCreate,
      version: 1,
    );

    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnTitle TEXT,"
        "$columnThumb TEXT,"
        "$columnServings TEXT,"
        "$columnTimes TEXT,"
        "$columnDificulty TEXT,"
        "$columnDatePublished TEXT,"
        "$columnDesc TEXT,"
        "$columnIngredient TEXT,"
        "$columnStep TEXT)";
    await db.execute(sql);
  }

  Future<void> addRecipe(CreateRecipe recipe) async {
    final Database db = await database;
    await db.insert(tableName, recipe.toMap());
  }

  Future<List<CreateRecipe>> getAllRecipe() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    return result.map((e) => CreateRecipe.fromMap(e)).toList();
  }

  Future<CreateRecipe> getRecipeById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return result.map((e) => CreateRecipe.fromMap(e)).first;
  }

  Future<void> updateRecipe(CreateRecipe recipe) async {
    final Database db = await database;
    await db.update(
      tableName,
      recipe.toMap(),
      where: '$columnId = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<void> deleteRecipe(int id) async {
    final Database db = await database;
    await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
