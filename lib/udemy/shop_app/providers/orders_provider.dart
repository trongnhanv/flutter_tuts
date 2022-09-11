import 'dart:convert';

import 'package:basic_tuts/udemy/shop_app/api/http_service.dart';
import 'package:basic_tuts/udemy/shop_app/providers/_extend_auth.dart';
import 'package:basic_tuts/udemy/shop_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Map<String, dynamic> get bodyData {
    return {
      'amount': amount,
      'products': products.map((e) => e.bodyData).toList(),
      'dateTime': dateTime.toIso8601String(),
    };
  }

  OrderItem copyWith(
      {String? id,
      double? amount,
      List<CartItem>? products,
      DateTime? dateTime}) {
    return OrderItem(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        products: products ?? this.products,
        dateTime: dateTime ?? this.dateTime);
  }

  OrderItem.fromJson(Map<String, dynamic> values)
      : id = values['id'],
        amount = values['amount'],
        dateTime = DateTime.parse(values['dateTime']),
        products = (values['products'] as List<dynamic>).map((e) {
          return CartItem.fromJson(e);
        }).toList();
}

class OrdersProvider with ChangeNotifier, ExtendAuth {
  List<OrderItem> _items = [];

  List<OrderItem> get items => [..._items];

  Future<void> fetchOrders() {
    return http
        .get(Uri.parse(HttpService.baseUri + '/orders.json?auth=$idToken'))
        .then((value) {
      HttpService.handleSuccess(value, (data) {
        List<OrderItem> loadData = [];
        data!.forEach((orderId, value) {
          value['id'] = orderId;
          loadData.add(OrderItem.fromJson(value));
        });
        _items = loadData;
        notifyListeners();
      });
    });
  }

  Future<void> addItem(List<CartItem> products, double amount) {
    if (products.isEmpty || amount == 0) {
      return Future.error(Exception('Invalid Order'));
    }
    var order = OrderItem(
        id: '', amount: amount, products: products, dateTime: DateTime.now());
    return http
        .post(Uri.parse(HttpService.baseUri + '/orders.json?auth=$idToken'),
            body: json.encode(order.bodyData))
        .then((value) {
      HttpService.handleSuccess(value, (body) {
        _items.insert(0, order.copyWith(id: body!['name']));
        notifyListeners();
      });
    });
  }
}
