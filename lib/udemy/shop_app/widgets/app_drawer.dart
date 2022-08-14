import 'package:basic_tuts/udemy/shop_app/pages/orders_page.dart';
import 'package:basic_tuts/udemy/shop_app/pages/products_overview_page.dart';
import 'package:basic_tuts/udemy/shop_app/pages/user_products_page.dart';
import 'package:flutter/material.dart';

class AppDrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? onNavigate;

  const AppDrawerItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onNavigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        ListTile(
          leading: Icon(icon),
          title: Text(label),
          onTap: onNavigate,
        ),
      ],
    );
  }
}

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
        AppDrawerItem(
            label: 'Shop',
            icon: Icons.shop,
            onNavigate: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewPage.routeName);
            }),
        AppDrawerItem(
            label: 'Orders',
            icon: Icons.payment,
            onNavigate: () {
              Navigator.of(context).pushReplacementNamed(OrdersPage.routeName);
            }),
        AppDrawerItem(
            label: 'Your Products',
            icon: Icons.category,
            onNavigate: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsPage.routeName);
            })
      ],
    ));
  }
}
