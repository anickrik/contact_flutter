import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart' as sql;


class SQLHelper {

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE category(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT
    )
    """);

  }
  static Future<void> createContactTable(sql.Database database) async {
    await database.execute("""CREATE TABLE contacts(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    fName TEXT,
    lName TEXT,
    mobileNumber TEXT,
    emailID TEXT,
    categoryID TEXT,
    imagePath TEXT
    )
    """);
  }

  static Future<sql.Database> db() async {
    final databasePath = await sql.getDatabasesPath();
    String path = join(databasePath, 'contacts_demo.db');

    return sql.openDatabase(
      path,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
        await createContactTable(database);
      },
    );
  }

  static Future<int> saveCategory(String name) async {
    final db = await SQLHelper.db();

    final data = {'name': name};
    final id = await db.insert('category', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await SQLHelper.db();
    return db.query('category', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getCategory(int id) async {
    final db = await SQLHelper.db();
    return db.query('category', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateCategory(int id, String name) async {
    final db = await SQLHelper.db();

    final data = {'name': name};
    final result =
        await db.update('category', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteCategory(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('category', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint(
          "Something went wrong while deleting at id = $id and Error is $err");
    }
  }

  static Future<int> saveContact(String fName, String lName, String mobileNumber, String emailID, String categoryID, String imagePath) async {
    final db = await SQLHelper.db();
    final data = {
      'fName' : fName,
      'lName': lName,
      'mobileNumber' : mobileNumber,
      'emailID' : emailID,
      'categoryID' : categoryID,
      'imagePath' : imagePath
    };
    final id = await db.insert('contacts', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await SQLHelper.db();
    return db.query('contacts', orderBy: "id");
  }


  static Future close() async {
    final db = await SQLHelper.db();
    db.close();
  }
}
