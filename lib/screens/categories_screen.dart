import 'package:flutter/material.dart';

import '../data/categories.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {

  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
      ),
      children: CATEGORIES.map(
        (category) =>
          CategoryItem(
            id: category.id,
            title: category.title, 
            color: category.color
          )
        ).toList(),
    );
  }
}