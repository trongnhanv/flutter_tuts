import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import './product_overview_item.dart';

class ProductOverviewGrid extends StatelessWidget {
  final bool onlyFavorite;
  const ProductOverviewGrid({Key? key, required this.onlyFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ProductsProviderV2>();
    var products = onlyFavorite ? provider.favoriteItems : provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (_, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: const ProductOverviewItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
