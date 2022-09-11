import 'package:basic_tuts/udemy/shop_app/providers/cart_provider.dart';
import 'package:basic_tuts/udemy/shop_app/providers/orders_provider.dart';
import 'package:basic_tuts/udemy/shop_app/utils/snackbar.dart';
import 'package:basic_tuts/udemy/shop_app/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/CartPage';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _orderSaving = false;
  @override
  Widget build(BuildContext context) {
    var cartProvider = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              const Text(
                'Total Amount',
                style: TextStyle(fontSize: 20),
              ),
              const Spacer(),
              Chip(
                label: Text(
                  "\$ ${cartProvider.totalAmount}",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText1!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              _orderSaving
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          _orderSaving = true;
                        });
                        context
                            .read<OrdersProvider>()
                            .addItem(cartProvider.items.values.toList(),
                                cartProvider.totalAmount)
                            .then((value) {
                          context.read<CartProvider>().clearCart();
                        }).catchError((e) {
                          showSnackBar(context, 'Something went wrong!');
                        }).whenComplete(() {
                          setState(() {
                            _orderSaving = false;
                          });
                        });
                      },
                      child: const Text(
                        'ORDER NOW',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
            ]),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: cartProvider.items.length,
                itemBuilder: (_, index) => CartItemWidget(
                    productId: cartProvider.items.keys.toList()[index],
                    cartItem: cartProvider.items.values.toList()[index])))
      ]),
    );
  }
}
