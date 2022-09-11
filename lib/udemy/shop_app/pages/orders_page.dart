import 'package:basic_tuts/udemy/shop_app/providers/orders_provider.dart';
import 'package:basic_tuts/udemy/shop_app/widgets/app_drawer.dart';
import 'package:basic_tuts/udemy/shop_app/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class OrdersPage extends StatefulWidget {
//   static const routeName = '/OrdersPage';
//   const OrdersPage({Key? key}) : super(key: key);

//   @override
//   State<OrdersPage> createState() => _OrdersPageState();
// }

// class _OrdersPageState extends State<OrdersPage> {
//   bool _loading = false;

//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(Duration.zero).then((value) {
//       setState(() {
//         _loading = true;
//       });
//       context.read<OrdersProvider>().fetchOrders().whenComplete(() {
//         setState(() {
//           _loading = false;
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var orders = context.watch<OrdersProvider>().items;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Orders Page'),
//       ),
//       body: _loading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: orders.length,
//               itemBuilder: (_, index) =>
//                   OrderItemWidget(orderItem: orders[index])),
//       drawer: const AppDrawer(),
//     );
//   }
// }

// class OrdersPage extends StatefulWidget {
//   static const routeName = '/OrdersPage';
//   const OrdersPage({Key? key}) : super(key: key);

//   @override
//   State<OrdersPage> createState() => _OrdersPageState();
// }

// class _OrdersPageState extends State<OrdersPage> {
//   var number = 0;
//   late Future _future;

//   @override
//   void initState() {
//     super.initState();
//     _future = context.read<OrdersProvider>().fetchOrders();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Orders Page'),
//       ),
//       body: FutureBuilder(
//         future: _future,
//         builder: (_, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.error != null) {
//             return const Center(
//               child: Text('Have an error occurred!'),
//             );
//           }
//           return Consumer<OrdersProvider>(builder: (_, data, __) {
//             var orders = data.items;
//             return ListView.builder(
//                 itemCount: orders.length,
//                 itemBuilder: (_, index) =>
//                     OrderItemWidget(orderItem: orders[index]));
//           });
//         },
//       ),
//       drawer: const AppDrawer(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             number += 1;
//           });
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
class OrdersPage extends StatelessWidget {
  static const routeName = '/OrdersPage';
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Page'),
      ),
      body: FutureBuilder(
        future: context.read<OrdersProvider>().fetchOrders(),
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Consumer<OrdersProvider>(builder: (_, data, __) {
                var orders = data.items;
                return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (_, index) =>
                        OrderItemWidget(orderItem: orders[index]));
              });

            default:
              return const Text('Unhandle State');
          }
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
