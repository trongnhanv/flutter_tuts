import 'package:basic_tuts/udemy/shop_app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/product_detail_page.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductOverviewItem extends StatefulWidget {
  const ProductOverviewItem({Key? key}) : super(key: key);

  @override
  State<ProductOverviewItem> createState() => _ProductOverviewItemState();
}

class _ProductOverviewItemState extends State<ProductOverviewItem> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    var product = context.watch<ProductProvider>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ProductDetailPage.routeName,
              arguments: ProductDetailArguments(productId: product.id));
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: _loading
                ? const CircularProgressIndicator()
                : IconButton(
                    icon: Icon(
                        product.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Theme.of(context).colorScheme.secondary),
                    onPressed: () {
                      setState(() {
                        _loading = true;
                      });
                      product.toggleFavourite().catchError((e) {
                        showSnackBar(context, 'Something went wrong!');
                      }).whenComplete(() {
                        setState(() {
                          _loading = false;
                        });
                      });
                    },
                  ),
            title: FittedBox(
              child: Text(
                product.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                var readProvider = context.read<CartProvider>();
                readProvider.addToCart(
                    product.id, product.title, product.price);

                var snackbar = SnackBar(
                  content: const Text('Added to cart successfully'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        readProvider.removeItemFromCart(product.id);
                      }),
                );

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              },
            ),
          ),
        ),
      ),
    );
  }
}
