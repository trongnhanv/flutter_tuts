import 'package:basic_tuts/udemy/shop_app/pages/cart_page.dart';
import 'package:basic_tuts/udemy/shop_app/widgets/app_drawer.dart';
import 'package:basic_tuts/udemy/shop_app/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_overview_grid.dart';

enum FilterOptions { onlyFavourites, showAll }

class ProductsOverviewPage extends StatefulWidget {
  static const routeName = '/ProductsOverviewPage';
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  FilterOptions _filterOptions = FilterOptions.showAll;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Overview Page'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions value) {
                setState(() {
                  _filterOptions = value;
                });
              },
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text('Only Favourites'),
                      value: FilterOptions.onlyFavourites,
                    ),
                    const PopupMenuItem(
                      child: Text('Show all'),
                      value: FilterOptions.showAll,
                    )
                  ]),
          Consumer<CartProvider>(
              builder: (_, cartProvider, __) => Badge(
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartPage.routeName);
                    },
                  ),
                  value: cartProvider.cartNumber.toString()))
        ],
      ),
      body: ProductOverviewGrid(
        onlyFavorite: _filterOptions == FilterOptions.onlyFavourites,
      ),
      drawer: const AppDrawer(),
    );
  }
}
