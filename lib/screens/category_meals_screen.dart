import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../data/meals.dart';

class CategoryMealsScreen extends StatelessWidget {

  static const routeName = '/category-meals';

  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'] as String;
    final categoryTitle = routeArgs['title'] as String;
    final categoryMeals = MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title, 
            imageUrl: categoryMeals[index].imageUrl, 
            duration: categoryMeals[index].duration, 
            complexity: categoryMeals[index].complexity, 
            affordability: categoryMeals[index].affordability
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}