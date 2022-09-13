import 'package:basic_tuts/youtube/19_food_app/utils/string.dart';
import 'package:flutter/material.dart';
import '../models/place_model.dart';
import '../db/places_table.dart';

class PlacesProvider with ChangeNotifier {
  final placeTable = PlacesTable();
  List<PlaceModel> _items = [];

  List<PlaceModel> get items => [..._items];

  Future<void> index() {
    return placeTable.all().then((value) {
      _items = value;
      notifyListeners();
    });
  }

  Future<void> store(PlaceModel place) {
    place = place.copyWith(id: getRandomString(5));
    return placeTable.insert(place).then((value) {
      if (!value) {
        throw Exception('Cannot insert place data!');
      }
      _items.add(place);
      notifyListeners();
    });
  }
}
