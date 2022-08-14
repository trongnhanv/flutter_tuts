import 'package:basic_tuts/udemy/meal_app/pages/tabs/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class MealSelection extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final void Function(bool value)? changeHandler;
  const MealSelection(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.value,
      this.changeHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: changeHandler);
  }
}

class MealSelectionItem {
  final String title;
  final String subtitle;
  final bool value;

  const MealSelectionItem(
      {required this.title, required this.subtitle, required this.value});

  MealSelectionItem copyWith({String? title, String? subtitle, bool? value}) {
    return MealSelectionItem(
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        value: value ?? this.value);
  }

  @override
  String toString() {
    return "title: $title, subtitle: $subtitle, value: ${value ? 'true' : 'false'}";
  }
}

class FiltersPage extends StatefulWidget {
  static const routeName = '/filters';
  const FiltersPage({Key? key}) : super(key: key);

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  List<MealSelectionItem> items = const [
    MealSelectionItem(
        title: 'Gluten-free',
        subtitle: 'Only include gluten-fee meals',
        value: false),
    MealSelectionItem(
        title: 'Lactose-free',
        subtitle: 'Only include lactose-fee meals',
        value: false),
    MealSelectionItem(
        title: 'Vegetarian',
        subtitle: 'Only include vegetarian meals',
        value: false),
    MealSelectionItem(
        title: 'Vegan', subtitle: 'Only include vegan meals', value: false),
  ];

  bool _value = false;

  List<Widget> _buildMealSelections() {
    List<Widget> widgets = [];
    for (var i = 0; i < items.length; i++) {
      widgets.add(MealSelection(
        title: items[i].title,
        subtitle: items[i].subtitle,
        value: items[i].value,
        changeHandler: (newValue) {
          setState(() {
            List<MealSelectionItem> clone = List.from(items);
            clone[i] = clone[i].copyWith(value: newValue);
            items = clone;
          });
        },
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filters Page")),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(children: [
          Text(
            'Adjust your meal selection.',
            style: Theme.of(context).textTheme.headline6,
          ),
          Expanded(
            child: ListView(children: [
              ..._buildMealSelections(),
            ]),
          )
        ]),
      ),
    );
  }
}
