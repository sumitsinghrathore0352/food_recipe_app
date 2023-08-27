import 'package:flutter/material.dart';
import 'package:food_app/screens/filters_screen.dart';
import 'package:food_app/screens/tabs_screen.dart';
import '../models/meals.dart';
import '../screens/category_meals_screen.dart';

class MainDrawer extends StatelessWidget {
  final List<Meal> favoriteMeals ;
  MainDrawer(this.favoriteMeals);
  Widget buildListTile (String title , IconData icon , VoidCallback tapHandller){
     return ListTile(
    leading: Icon(icon, size: 26),
    title: Text(
    title,
    style: TextStyle(
    fontWeight: FontWeight.bold
    ),
    ),
    onTap: tapHandller,
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
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
                "Cooking Up!",
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 30,
                   color:Colors.black54,
                 ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile("Meals", Icons.restaurant ,(){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TabsScreen(favoriteMeals))
            );
          }),
          SizedBox(
            height: 20,
          ),
          buildListTile("Settings", Icons.settings,(){
            Navigator.of(context).pushReplacementNamed
              (
                FiltersScreen.routeName
            );
          }),
        ],
      ),
    );
  }
}
