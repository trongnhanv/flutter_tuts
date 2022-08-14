import 'package:basic_tuts/youtube/19_food_app/utils/color.dart';
import 'package:basic_tuts/youtube/19_food_app/utils/string.dart';

import '../models/category.dart';

const int categoryNumber = 12;

List<Category> generateCategories() {
  List<Category> fakeCatogories = [];

  for (int i = 1; i <= categoryNumber; i++) {
    fakeCatogories.add(Category(
        id: i,
        content: '${getRandomString(6)} category',
        color: randomColor()));
  }

  return fakeCatogories;
}

var fakeCatogories = generateCategories();
