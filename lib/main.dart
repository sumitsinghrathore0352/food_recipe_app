import 'package:flutter/material.dart';
import 'package:food_app/dummy_data.dart';
import 'package:food_app/screens/category_meals_screen.dart';
import 'package:food_app/screens/filters_screen.dart';
import 'package:food_app/screens/meal_details_screen.dart';
import 'package:food_app/screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './models/meals.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters = {
    "gluten" : false,
    "lactose" : false,
    "vegan" : false,
    "vegetarian" : false,
};
  // storing available meals in a list
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriatedMeals = [];
  //this function check that user click on switch button in settins if yes it change the default value of _filters to true so meals of selected category are shown
  void _setFilters(Map<String , bool> filterData){
     setState(() {
       _filters = filterData;
       // this checks if value of _filters is unmatched(filter is on to remove particular category) then this remove meal of that category
       _availableMeals = DUMMY_MEALS.where((meal) {
            if(_filters["gluten"] == true && !meal.isGlutenFree){
              print("Removed meal ${meal.title} because of gluten filter");
              return false;
       }
            if(_filters["lactose"]== true && !meal.isLactoseFree){
              print("Removed meal ${meal.title} because of lactose filter");
              return false;
            }
            if(_filters["vegan"]== true && !meal.isVegan){
              print("Removed meal ${meal.title} because of lactose filter");
              return false;
            }
            if(_filters["vegetarian"]== true && !meal.isVegetarian){
              print("Removed meal ${meal.title} because of lactose filter");
              return false;
            }
            return true;
       }).toList();
     });
  }
  // this function add and remove meal in favotite screen
  void _toggleFavorite(String mealId){
    final existingIndex = _favoriatedMeals.indexWhere((meal) => meal.id == mealId);
    // existingIndex >=0 check either the meal is in favorite screen or not if existingIndex = -1
    // meal dose not in favorite screen if existingIndex >=0  is in favorite screen
    if(existingIndex >= 0){
       setState(() {
         _favoriatedMeals.removeAt(existingIndex);
       }
       );
    }
    else{
      setState(() {
        _favoriatedMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
  // this function tell us that if this conditon is match with any of the data or not
  bool _isMealFavorite(String id){
    return _favoriatedMeals.any((meal) => meal.id == id);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor:  Colors.deepPurple[200] ,
        primarySwatch: Colors.deepPurple,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
        ),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: TabsScreen(_favoriatedMeals),
      routes: {
        // "/" : (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName :(ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName :(ctx) => MealDetailScreen(_toggleFavorite , _isMealFavorite),
        FiltersScreen.routeName : (ctx) => FiltersScreen(_filters,_setFilters,_favoriatedMeals),
      },
      onGenerateRoute: (settings){
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

