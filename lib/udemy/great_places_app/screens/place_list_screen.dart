import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';
import '../providers/places_provider.dart';
import '../widgets/place_list_item.dart';
import '../../common/future_widget.dart';

class PlaceListScreen extends StatelessWidget with FutureWidget {
  static const routeName = 'place-list-screen';

  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: context.read<PlacesProvider>().index(),
        builder: (_, snapshot) =>
            Consumer<PlacesProvider>(builder: (_, data, __) {
          return buildFutureContent(snapshot,
              contentWidget: data.items.isEmpty
                  ? const Center(child: Text('Empty List!'))
                  : ListView.builder(
                      itemCount: data.items.length,
                      itemBuilder: (_, index) {
                        return PlaceListItem(place: data.items[index]);
                      }));
        }),
      ),
    );
  }
}
