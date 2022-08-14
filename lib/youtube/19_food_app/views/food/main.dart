import 'package:basic_tuts/youtube/19_food_app/fakers/food.dart';
import 'package:basic_tuts/youtube/19_food_app/models/category.dart';
import 'package:basic_tuts/youtube/19_food_app/models/food.dart';
import 'package:basic_tuts/youtube/19_food_app/views/food/widgets/item.dart';
import 'package:flutter/material.dart';

class FoodMainPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const FoodMainPage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Category category = data['category'] as Category;
    List<Food> foods = fakeFoods
        .where((element) => element.categoryId == category.id)
        .toList();
    // Category category = data['category'] as Category;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Food Screen',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
            itemCount: foods.length,
            itemBuilder: (_, index) {
              Food food = foods[index];
              return FoodItem(food: food);
            }));
  }
}
