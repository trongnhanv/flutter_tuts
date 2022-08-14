import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final String productId;
  final CartItem cartItem;
  const CartItemWidget(
      {Key? key, required this.productId, required this.cartItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        background: Container(
          color: Theme.of(context).errorColor,
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        ),
        direction: DismissDirection.endToStart,
        // confirmDismiss: (DismissDirection dismissDirection) async {},
        onDismissed: (direction) {
          context.read<CartProvider>().removeCardItem(productId);
        },
        key: ValueKey(cartItem.id),
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text("\$ ${cartItem.price}"),
                    ),
                  ),
                ),
                title: Text(cartItem.title),
                subtitle:
                    Text("Total: \$ ${cartItem.price * cartItem.quantity}"),
                trailing: Text("${cartItem.quantity} x"),
              ),
            )));
  }
}
