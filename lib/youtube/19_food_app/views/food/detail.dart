import 'package:basic_tuts/youtube/19_food_app/models/food.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FoodDetailPage extends StatelessWidget {
  final dynamic data;
  const FoodDetailPage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Food food = data['food'] as Food;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Food Detail Screen',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: CachedNetworkImage(
            imageUrl: food.url,
            imageBuilder: (context, imageProvider) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                Text(
                  food.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: food.ingredients?.length,
                        itemBuilder: (_, index) {
                          String ing = food.ingredients![index];
                          return ListTile(
                            leading: CircleAvatar(child: Text('${index + 1}')),
                            title: Text(
                              ing,
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        }))
              ],
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
              height: 250,
              width: 250,
              alignment: Alignment.center,
              child:
                  CircularProgressIndicator(value: downloadProgress.progress),
            ),
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          ),
        ));
  }
}
