import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {

  static const routeName = '/filters';
  final Function(Map<String, bool>) saveFilters;
  final Map<String, bool> currentFilters;

  const FiltersScreen({
    super.key,
    required this.saveFilters,
    required this.currentFilters
  });

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
  }

  Widget _buildSwitchListTile(
    String title,
    String subTitle,
    var currentValue,
    Function(bool) updateValue
  ) {
    return SwitchListTile(
            title: Text(title),
            subtitle: Text(subTitle),
            value: currentValue, 
            onChanged: updateValue,
            activeColor: Colors.amber,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan
              };
              widget.saveFilters(selectedFilters);
            }, 
            icon: const Icon(Icons.save)
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten Free',
                  'Only include gluten free meals', 
                  _glutenFree, 
                  (newValue) { 
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals', 
                  _vegetarian, 
                  (newValue) { 
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals', 
                  _vegan, 
                  (newValue) { 
                    setState(() {
                      _vegan = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                  'Lactose Free',
                  'Only include lactose free meals', 
                  _lactoseFree, 
                  (newValue) { 
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }),
              ],
            )
          )
        ],
      ),
    );
  }
}