import 'package:basic_tuts/youtube/19_food_app/fakers/category.dart';
import 'package:basic_tuts/youtube/19_food_app/views/category/widgets/item.dart';
import 'package:flutter/material.dart';

class CategoryMainPage extends StatelessWidget {
  const CategoryMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Application',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(20),
        child: GridView(
            children: fakeCatogories.map((e) => CategoryItem(item: e)).toList(),
            // Mẫu có sẵn trong GridView
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3 / 2, // Tỉ lệ chiều rộng / chiều cao
                crossAxisSpacing: 10, // Dộ rộng giữa chiều ngang
                mainAxisSpacing: 10 // Độ rộng giữ chiều dọc
                )),
      ),
    );
  }
}
