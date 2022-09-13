import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;

  const PlaceLocation(
      {required this.latitude, required this.longitude, this.address});
}

class PlaceModel {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File? image;

  const PlaceModel(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});

  PlaceModel copyWith(
      {String? id, String? title, PlaceLocation? location, File? image}) {
    return PlaceModel(
        id: id ?? this.id,
        title: title ?? this.title,
        location: location ?? this.location,
        image: image ?? this.image);
  }

  PlaceModel.fromJson(Map<String, dynamic> values)
      : id = values['id'],
        title = values['title'],
        location = values['location'],
        image = File(values['image_url']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      // 'location': location,
      'image_url': image!.path
    };
  }
}
