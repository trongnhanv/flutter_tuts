import 'package:basic_tuts/youtube/19_food_app/routes.dart';
import 'package:flutter/material.dart';

class FoodApplication extends StatelessWidget {
  const FoodApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.categoryMainPage,
      // routes: Routes.getRoutes(context),
      onGenerateRoute: Routes.onGenerateRoute,
      theme: ThemeData(fontFamily: 'OpenSans'),
    );
  }
}
