import 'package:basic_tuts/udemy/great_places_app/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/place_list_screen.dart';
import './screens/add_place_screen.dart';

class GreatPlacesApp extends StatelessWidget {
  const GreatPlacesApp({Key? key}) : super(key: key);

  ThemeData createThemeData() {
    ThemeData themeData = ThemeData(
      primarySwatch: Colors.indigo,
    );
    themeData = themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(secondary: Colors.amber));
    return themeData;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => PlacesProvider())],
        child: MaterialApp(
          title: 'Great Places',
          theme: createThemeData(),
          home: const PlaceListScreen(),
          onGenerateRoute: (RouteSettings settings) {
            Map<String, WidgetBuilder> routes = {
              PlaceListScreen.routeName: (context) => const PlaceListScreen(),
              AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
            };
            WidgetBuilder? builder = routes[settings.name];
            return MaterialPageRoute(builder: (ctx) => builder!(ctx));
          },
        ));
  }
}
