import 'package:basic_tuts/udemy/meal_app/models/meal.dart';
import 'package:flutter/material.dart';

class MealDetailArguments {
  final Meal meal;

  const MealDetailArguments({required this.meal});
}

class MealDetailNavigatorPopParams {
  final bool isDelete;

  const MealDetailNavigatorPopParams({this.isDelete = false});
}

class TitleContainer extends StatelessWidget {
  final String title;
  const TitleContainer({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

class ContentContainer extends StatelessWidget {
  final Widget content;

  const ContentContainer({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: content,
    );
  }
}

class MealDetailPage extends StatelessWidget {
  static const routeName = '/MealDetailPage';
  final MealDetailArguments arguments;
  const MealDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final routeArgs =
    //     ModalRoute.of(context)!.settings.arguments as MealDetailArguments;
    final meal = arguments.meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const TitleContainer(title: 'Ingredients'),
          ContentContainer(
              content: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) {
              return Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(meal.ingredients[index]),
                ),
              );
            },
            itemCount: meal.ingredients.length,
          )),
          const TitleContainer(title: 'Steps'),
          ContentContainer(
              content: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(child: Text("# ${index + 1}")),
                    title: Text(meal.steps[0]),
                  ),
                  const Divider(thickness: 1)
                ],
              );
            },
            itemCount: meal.steps.length,
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        backgroundColor: Theme.of(context).errorColor,
        onPressed: () {
          Navigator.of(context)
              .pop(const MealDetailNavigatorPopParams(isDelete: true));
        },
      ),
    );
  }
}
