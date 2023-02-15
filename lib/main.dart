import 'package:flutter/material.dart';

import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';
import './data/meals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false
  };

  List<Meal> _availableMeals = MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = MEALS.where((meal) {
        if (_filters['gluten'] == true &&
            !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true &&
            !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian'] == true &&
            !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] == true &&
            !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final exisitingIndex = 
      _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (exisitingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(exisitingIndex);
      });
    }
    else {
      setState(() {
        _favouriteMeals.add(MEALS.firstWhere((meal) => mealId == meal.id));
      });
    }
  }

  bool _isMealFavourite(String mealId) {
    print(mealId);
    return _favouriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DailyMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink
          ).copyWith(
            secondary: Colors.amber
          ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          bodyText2: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          headline1: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          )
        )
      ),
      home: TabsScreen(favouriteMeals: _favouriteMeals,),
      routes: {
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(toggleFavourite: _toggleFavourite, isFavourite: _isMealFavourite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(saveFilters: _setFilters, currentFilters: _filters,)
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}