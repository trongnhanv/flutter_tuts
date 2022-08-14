import 'dart:math';

import 'package:basic_tuts/youtube/19_food_app/models/food.dart';
import 'package:basic_tuts/youtube/19_food_app/utils/string.dart';
import './category.dart';

List<Food> getFoods() {
  List<Food> fakeFoods = [];
  int i = 1;
  List<Food> temp = [];
  while (i <= categoryNumber) {
    int minutes = i * 5;
    Food food = Food(
        name: '${getRandomString(6)} food',
        categoryId: i,
        duration: Duration(minutes: minutes),
        complexity:
            Complexity.values[Random().nextInt(Complexity.values.length)],
        ingredients: [
          '${getRandomString(3)} ing',
          '${getRandomString(3)} ing',
          '${getRandomString(3)} ing'
        ]);
    temp.add(food);
    fakeFoods.add(food);
    if (temp.length == 6) {
      i++;
      temp.length = 0;
    }
  }

  return fakeFoods;
}

List<Food> fakeFoods = getFoods();
