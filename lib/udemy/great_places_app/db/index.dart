import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DB {
  Future<Database> initDatabase(String tableName, String $fields) async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
        path.join(await getDatabasesPath(), 'great_place_app.db'),
        onCreate: (db, version) {
      return db.execute('CREATE TABLE $tableName(' + $fields + ')');
    }, version: 1);
  }
}
