import 'package:flutter/material.dart';
import 'package:food_app/widgets/main_drawer.dart';
import '../models/meals.dart';
class FiltersScreen extends StatefulWidget {
 
  static const routeName = "/filters";
  final Function saveFilters;
  final Map< String , bool> currentFilter;
  final List<Meal> favoriteMeals ;
  FiltersScreen(this.currentFilter,this.saveFilters,this.favoriteMeals);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree  = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilter["gluten"] ?? false;
    _lactoseFree = widget.currentFilter["lactose"] ?? false;
    _vegetarian = widget.currentFilter["vegetarian"] ?? false;
    _vegan = widget.currentFilter["vegan"] ?? false;

    super.initState();
  }

  Widget _buildSwitchListTiles(String title , String description, bool currentValue ,void Function(bool) updateValue){
    return   SwitchListTile(value: currentValue, onChanged: updateValue, title: Text(title),
      subtitle: Text(description),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Settings"),
        actions: [
          IconButton(onPressed: () {
            final selectedFilters ={
              "gluten" : _glutenFree,
              "lactose" : _lactoseFree,
              "vegan" : _vegan,
              "vegetarian" : _vegetarian,
            };
            widget.saveFilters(selectedFilters);
            print("changes saved");
           }, icon: Icon(Icons.save))
        ],
      ),
      //  final List<Meal> favoriteMeals ;
      drawer: MainDrawer(widget.favoriteMeals),
      body: Column(
      children: [
         Container(
           padding: EdgeInsets.all(20),
           child: Text(
             "Adjust your meal selection",
             style: Theme.of(context).textTheme.headline6,
           ),
           
         ),
        Expanded(child: ListView(
          children: [
               _buildSwitchListTiles("Gulteen-free", "Only include gluteen free meals", _glutenFree ?? false, (newValue) {
                 setState(() {
                   _glutenFree = newValue;
                 });
               }),

            _buildSwitchListTiles("Lactose-free", "Only include lactose free meals", _lactoseFree ,  (newValue) {
              setState(() {
                _lactoseFree = newValue;
              });
            }),
            _buildSwitchListTiles("Vegitarian", "Only include vegitarian meals", _vegetarian , (newValue) {
              setState(() {
                _vegetarian = newValue;
              });
            }),
            _buildSwitchListTiles("Vegan", "Only include Vegan meals", _vegan , (newValue) {
              setState(() {
               _vegan = newValue;
              });
            }),
          ],
        ))
      ],
      ),
    );
  }
}
