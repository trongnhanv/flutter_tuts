import 'package:flutter/material.dart';
import '../models/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<PlaceModel> _items = [];

  List<PlaceModel> get items => [..._items];
}
