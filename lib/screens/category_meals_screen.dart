import 'package:flutter/material.dart';
import 'package:food_app/widgets/meal_item.dart';
import '../dummy_data.dart';
import '/models/meals.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = "/category-meals";
  final List<Meal> availableMeal;
  CategoryMealsScreen(this.availableMeal);
  // final String categoryId;
  // final String categoryTitle;
  // CategoryMeals(this.categoryId,this.categoryTitle);
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (routeArgs == null) {
      // Handle the case where routeArgs is null, e.g., by showing an error message or returning to a previous screen.
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("An error occurred."),
        ),
      );
    }

    final categoryTitle = routeArgs["title"] ?? "Default Title";
    final categoryId = routeArgs["id"] ?? "Default Id";
    final categoryMeals = availableMeal.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: categoryMeals.length,
            itemBuilder: (ctx , index){
             return MealItem(
               id: categoryMeals[index].id ,
               title: categoryMeals[index].title,
               imageUrl: categoryMeals[index].imageUrl,
               duration: categoryMeals[index].duration,
               affordability: categoryMeals[index].affordability,
               complexity: categoryMeals[index].complexity,
             );
        }),
      ),
    );
  }
}
