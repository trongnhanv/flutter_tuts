import 'package:basic_tuts/udemy/shop_app/pages/edit_user_product_page.dart';
import 'package:basic_tuts/udemy/shop_app/providers/product_provider.dart';
import 'package:basic_tuts/udemy/shop_app/providers/products_provider.dart';
import 'package:basic_tuts/udemy/shop_app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatefulWidget {
  final ProductProvider product;
  const UserProductItem({Key? key, required this.product}) : super(key: key);

  @override
  State<UserProductItem> createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem> {
  bool loading = false;
  Future<void> _handleDelete(BuildContext context) async {
    bool confirm = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to remove the item?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(_).pop(false);
                    },
                    child: const Text('No')),
                TextButton(
                    onPressed: () {
                      Navigator.of(_).pop(true);
                    },
                    child: const Text('Yes'))
              ],
            ));

    if (confirm) {
      setState(() {
        loading = true;
      });
      context
          .read<ProductsProviderV2>()
          .deleteProduct(widget.product.id)
          .catchError((e) {
        showSnackBar(context, 'aaaa');
      }).whenComplete(() {
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.product.imageUrl)),
          title: Text(widget.product.title),
          trailing: SizedBox(
            width: 100,
            child: Row(children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        EditUserProductPage.routeName,
                        arguments:
                            EditUserProductArguments(id: widget.product.id));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  )),
              loading
                  ? const CircularProgressIndicator()
                  : IconButton(
                      onPressed: () {
                        _handleDelete(context);
                      },
                      icon: Icon(Icons.delete,
                          color: Theme.of(context).errorColor))
            ]),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
