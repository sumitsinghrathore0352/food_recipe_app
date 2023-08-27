import 'package:flutter/material.dart';
import 'package:food_app/screens/favorites_screen.dart';
import 'package:food_app/widgets/main_drawer.dart';
import './categories_screen.dart';
import '../models/meals.dart';
class TabsScreen extends StatefulWidget {

  final List<Meal> favoriteMeals ;
  TabsScreen(this.favoriteMeals);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;
  int _selectedPageIndex = 0;
  @override
 void initState(){
   _pages =[
     {"page" : CategoriesScreen(), "title" : " Categories"},
     {"page" :  FavoritesScreen(widget.favoriteMeals), "title" : " Your Favorites"},

   ];
   super.initState();
 }

  void _selectPage(int index){
      setState(() {
        _selectedPageIndex = index;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(_pages[_selectedPageIndex]["title"]),
      ),
      drawer: MainDrawer(widget.favoriteMeals),
      body:_pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        onTap:  _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
            label:  "Category"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label:  "Favorites"
          ),
        ],
      )
    ) ;
  }
}
// DefaultTabController(
// length: 2,
// initialIndex: 0,
// child: Scaffold(
// appBar: AppBar(
// title: Text("Meals"),
// bottom: TabBar(tabs: [
// Tab(icon: Icon(Icons.category), text: "Categories",),
// Tab(icon: Icon(Icons.star), text: "Favorites",),
// ]),
// ),
// body: TabBarView(children: [
// CategoriesScreen(),
// FavoritesScreen(),
// ],
//
// ),
// ),
// )