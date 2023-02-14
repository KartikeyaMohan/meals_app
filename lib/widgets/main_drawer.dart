import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
          leading: Icon(
            icon,
            size: 26
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
          onTap: tapHandler,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.amber,
            child: const Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.pink
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushNamed('/');
          }),
          buildListTile('Filters', Icons.settings, () {
            Navigator.of(context).pushNamed(FiltersScreen.routeName);
          })
        ]
      ),
    );
  }
}