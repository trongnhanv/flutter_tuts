import 'package:basic_tuts/youtube/19_food_app/views/category/main.dart';
import 'package:basic_tuts/youtube/19_food_app/views/food/detail.dart';
import 'package:basic_tuts/youtube/19_food_app/views/food/main.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String categoryMainPage = '/';
  static const String foodMainPage = '/foods';
  static const String foodDetailPage = '/foods/view';

  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      categoryMainPage: (context) => const CategoryMainPage(),
      foodMainPage: (context) => const FoodMainPage()
    };
  }

  static MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    Widget page = const CategoryMainPage();
    String? routeName = settings.name;
    switch (routeName) {
      case foodMainPage:
        page = FoodMainPage(
          data: settings.arguments,
        );
        break;
      case foodDetailPage:
        page = FoodDetailPage(
          data: settings.arguments,
        );
        break;
      default:
        break;
    }

    return MaterialPageRoute(builder: (context) => page);
  }

  static onUnknownRoute(RouteSettings settings) {}
}
