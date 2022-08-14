import 'package:basic_tuts/udemy/meal_app/models/category.dart';
import '../../meals/meals.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({Key? key, required this.category}) : super(key: key);

  void _chooseCategory(BuildContext context) {
    // Navigator.of(_).push(MaterialPageRoute(builder: (__) {
    //   return MealsPage(category: category);
    // }));
    Navigator.of(context).pushNamed(MealsPage.routeName,
        arguments: MealsArguments(category: category));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _chooseCategory(context);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child:
            Text(category.title, style: Theme.of(context).textTheme.headline6),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [category.color.withOpacity(0.7), category.color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
