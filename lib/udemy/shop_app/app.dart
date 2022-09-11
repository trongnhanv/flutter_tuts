import 'package:basic_tuts/udemy/shop_app/pages/auth_page.dart';
import 'package:basic_tuts/udemy/shop_app/pages/cart_page.dart';
import 'package:basic_tuts/udemy/shop_app/pages/edit_user_product_page.dart';
import 'package:basic_tuts/udemy/shop_app/pages/orders_page.dart';
import 'package:basic_tuts/udemy/shop_app/pages/user_products_page.dart';
import 'package:basic_tuts/udemy/shop_app/providers/auth_provider.dart';
import 'package:basic_tuts/udemy/shop_app/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/products_overview_page.dart';
import './pages/product_detail_page.dart';
import './providers/products_provider.dart';
import './providers/cart_provider.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData =
        ThemeData(primarySwatch: Colors.purple, fontFamily: 'Lato');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProviderV2>(
            create: (_) => ProductsProviderV2(),
            update: (_, provider, notifier) => notifier!..update(provider)),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
            create: (_) => OrdersProvider(),
            update: (_, provider, notifier) => notifier!..update(provider))
      ],
      child: Consumer<AuthProvider>(
        builder: (context, data, child) => MaterialApp(
          title: 'ShopApplication',
          debugShowCheckedModeBanner: false,
          theme: themeData.copyWith(
              colorScheme:
                  themeData.colorScheme.copyWith(secondary: Colors.deepOrange)),
          home: !data.isLoggedIn
              ? const AuthPage()
              : const ProductsOverviewPage(),
          onGenerateRoute: (RouteSettings settings) {
            Map<String, WidgetBuilder> routes = {
              AuthPage.routeName: (context) => const AuthPage(),
              ProductsOverviewPage.routeName: (context) =>
                  const ProductsOverviewPage(),
              ProductDetailPage.routeName: (context) => ProductDetailPage(
                    arguments: settings.arguments as ProductDetailArguments,
                  ),
              CartPage.routeName: (context) => const CartPage(),
              OrdersPage.routeName: (context) => const OrdersPage(),
              UserProductsPage.routeName: (context) => const UserProductsPage(),
              EditUserProductPage.routeName: (context) => EditUserProductPage(
                  arguments: settings.arguments as EditUserProductArguments),
            };
            WidgetBuilder? builder = routes[settings.name];
            return MaterialPageRoute(builder: (ctx) => builder!(ctx));
          },
        ),
      ),
    );
  }
}
