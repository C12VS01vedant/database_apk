import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, 'my_database.db');

      return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE my_table(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              dob TEXT,
              address TEXT
            )
          ''');
        },
      );
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  Future<int> insertData(String name, DateTime dob, String address) async {
    try {
      final db = await instance.database;
      String dobDateOnly = "${dob.year}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}";

      return await db.insert('my_table', {
        'name': name,
        'dob': dobDateOnly,
        'address': address,
      });
    } catch (e) {
      print('Error inserting data: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    try {
      final db = await instance.database;
      return await db.query('my_table');
    } catch (e) {
      print('Error getting all data: $e');
      rethrow;
    }
  }

  Future<int> updateData(int id, String name, DateTime dob, String address) async {
    try {
      final db = await instance.database;
      String dobDateOnly = "${dob.year}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}";

      return await db.update(
        'my_table',
        {
          'name': name,
          'dob': dobDateOnly,
          'address': address,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error updating data: $e');
      rethrow;
    }
  }

  Future<int> deleteData(int id) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'my_table',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting data: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getDataById(int id) async {
    try {
      final db = await instance.database;
      List<Map<String, dynamic>> result = await db.query(
        'my_table',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isNotEmpty) {
        Map<String, dynamic> data = result.first;
        // Ensure that 'dob' is not null and is a non-empty String
        if (data['dob'] != null && data['dob'].toString().isNotEmpty) {
          // Convert the 'dob' field to a DateTime object
          DateTime dob = DateTime.parse(data['dob'].toString());
          // Update the 'dob' field in the data map
          data['dob'] = dob;
        }
        return data;
      }

      return null;
    } catch (e) {
      print('Error getting data by id: $e');
      return null;
    }
  }
}
