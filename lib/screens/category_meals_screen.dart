import 'package:flutter/material.dart';
import 'package:meals_app/enums/affordability.dart';
import 'package:meals_app/enums/complexity.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {

  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  const CategoryMealsScreen({
    super.key,
    required this.availableMeals
  });

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String? categoryTitle;
  List<Meal>? displayedMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      super.didChangeDependencies();
      final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'] as String;
      categoryTitle = routeArgs['title'] as String;
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals?.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle as String),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals?[index].id as String,
            title: displayedMeals?[index].title as String, 
            imageUrl: displayedMeals?[index].imageUrl as String, 
            duration: displayedMeals?[index].duration as int, 
            complexity: displayedMeals?[index].complexity as Complexity, 
            affordability: displayedMeals?[index].affordability as Affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals?.length,
      ),
    );
  }
}