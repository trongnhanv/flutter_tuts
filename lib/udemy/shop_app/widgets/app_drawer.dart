import 'package:basic_tuts/udemy/shop_app/pages/orders_page.dart';
import 'package:basic_tuts/udemy/shop_app/pages/products_overview_page.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: const Text('Shopping Drawer'),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: () {
            Navigator.of(context).pushNamed(ProductsOverviewPage.routeName);
          },
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Orders'),
          onTap: () {
            Navigator.of(context).pushNamed(OrdersPage.routeName);
          },
        )
      ],
    ));
  }
}
