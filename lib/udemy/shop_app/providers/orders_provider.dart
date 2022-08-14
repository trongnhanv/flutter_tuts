import 'package:basic_tuts/udemy/shop_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class OrdersProvider with ChangeNotifier {
  final List<OrderItem> _items = [];

  List<OrderItem> get items => [..._items];

  void addItem(List<CartItem> products, double amount) {
    DateTime now = DateTime.now();
    _items.insert(
        0,
        OrderItem(
            id: now.toString(),
            amount: amount,
            products: products,
            dateTime: now));
    notifyListeners();
  }
}
