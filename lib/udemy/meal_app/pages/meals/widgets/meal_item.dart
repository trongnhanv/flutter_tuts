import 'package:basic_tuts/udemy/meal_app/models/meal.dart';
import 'package:basic_tuts/udemy/meal_app/pages/meal_detail/meal_detail.dart';
import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final double space;

  const IconText(
      {Key? key, required this.icon, required this.text, this.space = 6})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: space,
        ),
        Text(text)
      ],
    );
  }
}

class MealItem extends StatelessWidget {
  final Meal meal;
  final void Function(Meal meal) deleteHanler;
  const MealItem({Key? key, required this.meal, required this.deleteHanler})
      : super(key: key);

  void _chooseMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailPage.routeName,
            arguments: MealDetailArguments(meal: meal))
        .then((value) {
      var params = value as MealDetailNavigatorPopParams;
      if (params.isDelete) {
        deleteHanler(meal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _chooseMeal(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    meal.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    color: Colors.black54,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      meal.title,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconText(
                        icon: Icons.schedule, text: "${meal.duration} mins"),
                    IconText(icon: Icons.work, text: meal.complexityText),
                    IconText(
                        icon: Icons.attach_money, text: meal.affordabilityText),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
