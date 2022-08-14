import 'package:basic_tuts/udemy/meal_app/dummy.dart';
import 'package:basic_tuts/udemy/meal_app/models/category.dart';
import 'package:basic_tuts/udemy/meal_app/models/meal.dart';
import 'package:basic_tuts/udemy/meal_app/pages/meals/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class MealsArguments {
  final Category category;

  const MealsArguments({required this.category});
}

class MealsPage extends StatefulWidget {
  static const routeName = '/MealsPage';
  final MealsArguments arguments;
  const MealsPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  late List<Meal> displayedMeals;

  void _deleteMealItem(Meal meal) {
    setState(() {
      displayedMeals.remove(meal);
    });
  }

  @override
  void initState() {
    super.initState();
    displayedMeals = dummyMeals
        .where(
            (meal) => meal.categoryIds.contains(widget.arguments.category.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.arguments.category.title)),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return MealItem(
            meal: displayedMeals[index],
            deleteHanler: _deleteMealItem,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
