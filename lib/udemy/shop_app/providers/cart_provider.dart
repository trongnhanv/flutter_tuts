import 'package:flutter/material.dart';

typedef CartListType = Map<String, CartItem>;

class CartItem {
  final String id;
  final String title;
  final double price;
  int quantity;

  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      this.quantity = 1});

  CartItem updateQuantity(int quantity) {
    this.quantity = quantity;
    return this;
  }

  Map<String, dynamic> get bodyData {
    return {
      'id': id,
      'title': title,
      'price': price,
      'quantity': quantity,
    };
  }

  CartItem.fromJson(Map<String, dynamic> values)
      : id = values['id'],
        title = values['title'],
        price = values['price'],
        quantity = values['quantity'];
}

class CartProvider with ChangeNotifier {
  CartListType _items = {};

  CartListType get items => _items;

  int get cartNumber => _items.length;

  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addToCart(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId, (value) => value.updateQuantity(value.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
              ));
    }
    notifyListeners();
  }

  void removeItemFromCart(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId, (value) => value.updateQuantity(value.quantity - 1));
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void removeCardItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
