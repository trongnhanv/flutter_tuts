import 'package:flutter/material.dart';
import '../models/product.dart';
import './product_provider.dart';

class ProductProviderV1 with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items => _items;

  void updateItem(int index, Product item) {
    _items[index] = item;
    notifyListeners();
  }

  void add(Product item) {
    _items.add(item);
    notifyListeners();
  }

  void toggleFavourite(Product product) {
    var index = _items.indexWhere((item) => item.id == product.id);
    if (index > -1) {
      product.isFavourite = !product.isFavourite;
      updateItem(index, product);
    }
  }
}

class ProductsProviderV2 with ChangeNotifier {
  final List<ProductProvider> _items = [
    ProductProvider(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductProvider(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductProvider(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductProvider(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // bool _onlyFavourites = false;

  List<ProductProvider> get items {
    return [..._items];
  }

  ProductProvider findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<ProductProvider> get favoriteItems {
    return [..._items].where((element) {
      return element.isFavourite == true;
    }).toList();
  }

  // void setOnlyFavourites(bool value) {
  //   _onlyFavourites = value;
  //   notifyListeners();
  // }

  // void updateItem(int index, Product item) {
  //   _items[index] = item;
  //   notifyListeners();
  // }

  // void add(Product item) {
  //   _items.add(item);
  //   notifyListeners();
  // }

  // void toggleFavourite(Product product) {
  //   var index = _items.indexWhere((item) => item.id == product.id);
  //   if (index > -1) {
  //     product.isFavourite = !product.isFavourite;
  //     updateItem(index, product);
  //   }
  // }
}
