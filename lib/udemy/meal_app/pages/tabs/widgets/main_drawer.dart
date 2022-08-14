import 'package:basic_tuts/udemy/meal_app/pages/filters/filters.dart';
import 'package:basic_tuts/udemy/meal_app/pages/tabs/tabs.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? pressHander;

  const DrawerItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.pressHander})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          label,
          style: const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        onTap: pressHander);
  }
}

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      Container(
        height: 120,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        color: Theme.of(context).colorScheme.secondary,
        child: Text(
          'Cooking up!',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'RobotoCondensed',
              fontSize: 30,
              color: Theme.of(context).primaryColor),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      DrawerItem(
          label: 'Meals',
          icon: Icons.restaurant,
          pressHander: () {
            Navigator.of(context).pushReplacementNamed(TabsPage.routeName);
          }),
      DrawerItem(
          label: 'Filters',
          icon: Icons.settings,
          pressHander: () {
            Navigator.of(context).pushReplacementNamed(FiltersPage.routeName);
          }),
    ]));
  }
}
