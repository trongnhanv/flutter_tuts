import 'package:basic_tuts/youtube/19_food_app/routes.dart';
import 'package:flutter/material.dart';
import '../../../models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category item;
  const CategoryItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => FoodMainPage(
        //               category: item,
        //             )));
        Navigator.pushNamed(context, Routes.foodMainPage,
            arguments: {'category': item});
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              item.color.withOpacity(0.6),
              item.color,
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          item.content,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        )),
      ),
    );
  }
}
