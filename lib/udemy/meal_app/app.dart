import 'package:basic_tuts/udemy/meal_app/pages/filters/filters.dart';
import 'package:basic_tuts/udemy/meal_app/pages/meal_detail/meal_detail.dart';
import 'package:basic_tuts/udemy/meal_app/pages/meals/meals.dart';
import 'package:basic_tuts/udemy/meal_app/pages/tabs/tabs.dart';

import 'pages/categories/categories.dart';
import 'package:flutter/material.dart';

class MealApp extends StatelessWidget {
  const MealApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold),
            bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1))));
    return MaterialApp(
      title: 'MealApp',
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber)),
      initialRoute: TabsPage.routeName,
      // routes: {
      //   TabsPage.routeName: (context) => const TabsPage(),
      //   CategoriesPage.routeName: (context) => const CategoriesPage(),
      //   MealsPage.routeName: (context) => const MealsPage(),
      //   MealDetailPage.routeName: (context) => const MealDetailPage(),
      //   FiltersPage.routeName: (context) => const FiltersPage()
      // },
      onGenerateRoute: (RouteSettings settings) {
        Map<String, WidgetBuilder> routes = {
          TabsPage.routeName: (context) => const TabsPage(),
          CategoriesPage.routeName: (context) => const CategoriesPage(),
          MealsPage.routeName: (context) => MealsPage(
                arguments: settings.arguments as MealsArguments,
              ),
          MealDetailPage.routeName: (context) => MealDetailPage(
              arguments: settings.arguments as MealDetailArguments),
          FiltersPage.routeName: (context) => const FiltersPage()
        };
        WidgetBuilder? builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      },
    );
  }
}
