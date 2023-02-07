// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../../model/category/category.dart';
// import '../../model/contact/Contact.dart';
//
// class CategoriesDatabase {
//   static final CategoriesDatabase instance = CategoriesDatabase._init();
//
//   static Database? _database;
//
//   CategoriesDatabase._init();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//
//     _database = await _initDB('contacts2.db');
//     return _database!;
//   }
//
//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);
//
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }
//
//   Future _createDB(Database db, int version) async {
//     const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     const textType = 'TEXT NOT NULL';
//     const intType = 'INTEGER NOT NULL';
//
//     await db.execute("""
//     CREATE TABLE $tableCategories(
//     ${CategoryFields.id} $idType,
//     ${CategoryFields.name} $textType
//     )
//     """);
//
//     // await db.execute(
//     //     "CREATE TABLE Contact(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, mobileNo TEXT,emailId TEXT, )");
//
//     await db.execute("""
//     CREATE TABLE $tableContact(
//     ${ContactFields.id} $idType,
//     ${ContactFields.firstName} $textType,
//     ${ContactFields.lastName} $textType,
//     ${ContactFields.mobileNo} $textType,
//     ${ContactFields.emailId} $textType,
//     ${ContactFields.categoryName} $textType,
//     ${ContactFields.categoryId} $intType,
//     ${ContactFields.imagePath} $textType,
//     )
//     """);
//     print("Created tables");
//   }
//
//
//
//   Future<Category> create(Category category) async {
//     final db = await instance.database;
//
//     // final json = note.toJson();
//     // final columns =
//     //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
//     // final values =
//     //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
//     // final id = await db
//     //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
//
//     final id = await db.insert(tableCategories, category.toJson());
//     return category.copy(id: id);
//   }
//
//   Future<Category> readNote(int id) async {
//     final db = await instance.database;
//
//     final maps = await db.query(
//       tableCategories,
//       columns: CategoryFields.values,
//       where: '${CategoryFields.id} = ?',
//       whereArgs: [id],
//     );
//
//     if (maps.isNotEmpty) {
//       return Category.fromJson(maps.first);
//     } else {
//       throw Exception('ID $id not found');
//     }
//   }
//
//   Future<List<Category>> readAllNotes() async {
//     final db = await instance.database;
//
//     const orderBy = '${CategoryFields.id}';
//     // final result =
//     //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
//     final result = await db.query(tableCategories, orderBy: orderBy);
//     return result.map((json) => Category.fromJson(json)).toList();
//   }
//
//   Future<int> update(Category category) async {
//     final db = await instance.database;
//
//     return db.update(
//       tableCategories,
//       category.toJson(),
//       where: '${CategoryFields.id} = ?',
//       whereArgs: [category.id],
//     );
//   }
//
//   Future<int> delete(int id) async {
//     final db = await instance.database;
//
//     return await db.delete(
//       tableCategories,
//       where: '${CategoryFields.id} = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future close() async {
//     final db = await instance.database;
//
//     db.close();
//   }
// }
