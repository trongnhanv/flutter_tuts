import 'package:basic_tuts/udemy/shop_app/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../providers/product_provider.dart';

class ProductDetailArguments {
  final String productId;
  const ProductDetailArguments({required this.productId});
}

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/ProductDetailPage';
  final ProductDetailArguments arguments;
  const ProductDetailPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        context.read<ProductsProviderV2>().findById(arguments.productId);
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Image.network(product.imageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "\$ ${product.price}",
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              product.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
