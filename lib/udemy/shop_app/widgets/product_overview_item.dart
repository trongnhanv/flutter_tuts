import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/product_detail_page.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductOverviewItem extends StatelessWidget {
  const ProductOverviewItem({Key? key}) : super(key: key);

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
            leading: IconButton(
              icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary),
              onPressed: () {
                // context.read<ProductsProviderV2>().toggleFavourite(product);
                product.toggleFavourite();
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
                context
                    .read<CartProvider>()
                    .addToCart(product.id, product.title, product.price);
              },
            ),
          ),
        ),
      ),
    );
  }
}
