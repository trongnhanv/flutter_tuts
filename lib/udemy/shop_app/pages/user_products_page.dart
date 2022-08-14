import 'package:basic_tuts/udemy/shop_app/providers/products_provider.dart';
import 'package:basic_tuts/udemy/shop_app/widgets/app_drawer.dart';
import 'package:basic_tuts/udemy/shop_app/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsPage extends StatelessWidget {
  static const routeName = '/UserProductsPage';
  const UserProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var products = context.watch<ProductsProviderV2>().items;
    print(products);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, index) =>
                UserProductItem(product: products[index])),
      ),
      drawer: const AppDrawer(),
    );
  }
}
