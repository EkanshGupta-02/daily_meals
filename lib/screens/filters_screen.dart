import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function savefilters;
  final Map<String,bool> initialfilters;

  FiltersScreen(@required this.initialfilters,@required this.savefilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenfree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactosefree = false;

  @override
  void initState() {
    _glutenfree = widget.initialfilters['gluten'];
    _lactosefree = widget.initialfilters['lactose'];
    _vegetarian = widget.initialfilters['vegatarian'];
    _vegan = widget.initialfilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currval,
    Function updatevalue,
  ) {
    return SwitchListTile(
      title: Text(title  ?? 'Random'),
      value: currval ?? false,
      subtitle: Text(description ?? 'Random Description'),
      onChanged: updatevalue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedfilters = {
                'gluten': _glutenfree,
                'lactose':_lactosefree,
                'vegan':_vegan,
                'vegetarian':_vegetarian,
              };
              widget.savefilters(selectedfilters);
            },
            icon: Icon(Icons.save_alt),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust Your Meal",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile('Gluten-Free',
                    'Only include gluten-free meals.', _glutenfree, (newvalue) {
                  setState(() {
                    _glutenfree = newvalue ?? false;
                  });
                }),
                _buildSwitchListTile(
                    'Lactose-Free',
                    'Only include Lactose-free meals.',
                    _lactosefree, (newvalue) {
                  setState(() {
                    _lactosefree = newvalue ?? false;
                  });
                }),
                _buildSwitchListTile(
                    'Vegtarian', 'Only include Vegetarian meals.', _vegetarian,
                    (newvalue) {
                  setState(() {
                    _vegetarian = newvalue ?? false;
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', 'Only include Vegan meals.', _vegan, (newvalue) {
                  setState(() {
                    _vegan = newvalue ?? false;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
