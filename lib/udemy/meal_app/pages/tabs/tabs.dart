import 'package:basic_tuts/udemy/meal_app/pages/categories/categories.dart';
import 'package:basic_tuts/udemy/meal_app/pages/favourites/favourites.dart';
import 'package:basic_tuts/udemy/meal_app/pages/tabs/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  final String label;
  final IconData icon;
  final Widget page;

  const NavigationItem(
      {required this.label, required this.icon, required this.page});
}

class TabsPage extends StatefulWidget {
  static const routeName = '/';

  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final _navigationItems = const [
    NavigationItem(
        label: 'Categories', icon: Icons.category, page: CategoriesPage()),
    NavigationItem(
        label: 'Favourites', icon: Icons.star, page: FavouritesPage()),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meals'),
        ),
        drawer: const MainDrawer(),
        body: _navigationItems[_currentIndex].page,
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Colors.white,
            currentIndex: _currentIndex,
            items: _navigationItems
                .map((navItem) => BottomNavigationBarItem(
                    icon: Icon(navItem.icon), label: navItem.label))
                .toList()));
  }
}
