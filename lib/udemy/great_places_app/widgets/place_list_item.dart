import 'package:flutter/material.dart';
import '../models/place_model.dart';

class PlaceListItem extends StatelessWidget {
  final PlaceModel place;
  const PlaceListItem({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: FileImage(place.image!)),
      title: Text(place.title),
    );
  }
}
