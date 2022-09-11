import 'dart:convert';

import 'package:basic_tuts/udemy/shop_app/api/http_service.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import './product_provider.dart';
import 'package:http/http.dart' as http;
import './_extend_auth.dart';

class ProductProviderV1 with ChangeNotifier {
  final List<Product> _items = [];

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

class ProductsProviderV2 with ChangeNotifier, ExtendAuth {
  late List<ProductProvider> _items = [];

  List<ProductProvider> get items {
    return [..._items];
  }

  Future<void> loadProducts() {
    var url =
        'https://flutter-udemy-8281b-default-rtdb.firebaseio.com/products.json?auth=$idToken';

    return http.get(Uri.parse(url)).then((value) {
      HttpService.handleSuccess(value, (data) {
        List<ProductProvider> loadProducts = [];
        data!.forEach((productId, value) {
          loadProducts.add(ProductProvider(
              id: productId,
              title: value['title'],
              description: value['description'],
              price: double.parse(value['price'].toString()),
              imageUrl: value['imageUrl']));
        });
        _items = loadProducts;
        notifyListeners();
      });
    });
  }

  ProductProvider findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<ProductProvider> get favoriteItems {
    return [..._items].where((element) {
      return element.isFavourite == true;
    }).toList();
  }

  Future<void> saveProduct(ProductProvider product) {
    var index = _items.indexWhere((element) => element.id == product.id);
    var url =
        'https://flutter-udemy-8281b-default-rtdb.firebaseio.com/products';
    Future<void> callback;
    if (index >= 0) {
      url = '$url/${product.id}.json?auth=$idToken';
      callback = http
          .patch(Uri.parse(url), body: json.encode(product.bodyData))
          .then((response) {
        HttpService.handleSuccess(response, (_) {
          _items[index] = product;
        });
      });
    } else {
      url = '$url.json?auth=$idToken';
      callback = http
          .post(Uri.parse(url), body: json.encode(product.bodyData))
          .then((response) {
        HttpService.handleSuccess(response, (body) {
          _items.insert(0, product.copyWith(id: body!['name']));
        });
      });
    }
    return callback.then((value) {
      notifyListeners();
    });
  }

  Future<void> deleteProduct(String productId) {
    var index = _items.indexWhere((element) => element.id == productId);
    if (index < 0) {
      return Future.error('Nhan Vo Exception');
    }
    var url =
        'https://flutter-udemy-8281b-default-rtdb.firebaseio.com/products/$productId.json?auth=$idToken';

    return http.delete(Uri.parse(url)).then((value) {
      HttpService.handleSuccess(value, (_) {
        _items.removeWhere((element) => element.id == productId);
        notifyListeners();
      });
    });
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
