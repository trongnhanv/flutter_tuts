import 'package:sqflite/sqflite.dart';

import './index.dart';
import '../models/place_model.dart';

class PlacesTable extends DB {
  static const tableName = 'places';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnImageUrl = 'image_url';

  Future<Database> openDabase() {
    return initDatabase(tableName,
        '$columnId TEXT PRIMARY KEY, $columnTitle TEXT, $columnImageUrl TEXT');
  }

  Future<bool> insert(PlaceModel place) async {
    final db = await openDabase();
    var response = await db.insert(tableName, place.toJson());
    return response > 0;
  }

  Future<List<PlaceModel>> all() async {
    final db = await openDabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(
        maps.length, (index) => PlaceModel.fromJson(maps[index]));
  }
}
