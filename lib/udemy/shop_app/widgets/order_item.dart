import 'dart:math';

import 'package:basic_tuts/udemy/shop_app/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orderItem;
  const OrderItemWidget({Key? key, required this.orderItem}) : super(key: key);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _expaned = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          onTap: () {
            setState(() {
              _expaned = !_expaned;
            });
          },
          title: Text('\$ ${widget.orderItem.amount}'),
          subtitle: Text(
              DateFormat('dd/MM/y H:m:s').format(widget.orderItem.dateTime)),
          trailing: Icon(_expaned ? Icons.expand_less : Icons.expand_more),
        ),
        if (_expaned)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(widget.orderItem.products.length * 20 + 40, 180),
            child: ListView(
                children: widget.orderItem.products
                    .map((e) => Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                children: [
                                  Text("Quantity: ${e.quantity}"),
                                  Text("Price: \$ ${e.price}"),
                                ],
                              )
                            ],
                          ),
                        ))
                    .toList()),
          )
      ]),
    );
  }
}
