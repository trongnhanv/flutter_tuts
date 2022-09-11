import 'package:basic_tuts/udemy/shop_app/api/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  ProductProvider(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});

  ProductProvider copyWith(
      {String? id,
      String? title,
      String? description,
      double? price,
      String? imageUrl}) {
    return ProductProvider(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        isFavourite: isFavourite);
  }

  Map<String, dynamic> get bodyData {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavourite': isFavourite
    };
  }

  @override
  String toString() {
    return 'title: $title, description: $description, price: ${price.toStringAsFixed(2)}, imageUrl: $imageUrl';
  }

  Future<void> toggleFavourite() {
    var uri =
        'https://flutter-udemy-8281b-default-rtdb.firebaseio.com/products/$id.json';
    return http
        .patch(Uri.parse(uri),
            body: HttpService.parseBody({'isFavourite': !isFavourite}))
        .then((response) {
      HttpService.handleSuccess(response, (_) {
        isFavourite = !isFavourite;
        notifyListeners();
      });
    });
  }
}
