import 'package:basic_tuts/udemy/shop_app/providers/orders_provider.dart';
import 'package:basic_tuts/udemy/shop_app/widgets/app_drawer.dart';
import 'package:basic_tuts/udemy/shop_app/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/OrdersPage';
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orders = context.watch<OrdersProvider>().items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Page'),
      ),
      body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (_, index) => OrderItemWidget(orderItem: orders[index])),
      drawer: const AppDrawer(),
    );
  }
}
