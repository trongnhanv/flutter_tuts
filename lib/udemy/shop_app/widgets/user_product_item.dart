import 'package:basic_tuts/udemy/shop_app/providers/product_provider.dart';
import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final ProductProvider product;
  const UserProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading:
              CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
          title: Text(product.title),
          trailing: SizedBox(
            width: 100,
            child: Row(children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Theme.of(context).errorColor))
            ]),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
