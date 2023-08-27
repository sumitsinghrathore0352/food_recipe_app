import 'package:flutter/material.dart';
import '../dummy_data.dart';
class MealDetailScreen extends StatelessWidget {
  static const routeName = "/meal-detail";
  final void Function(String) toggleFavorite;
  final  Function(String) isFavorite;
  MealDetailScreen(this.toggleFavorite,this.isFavorite);
  Widget buildSectionTitle(BuildContext context,String text){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text , style: Theme.of(context).textTheme.headline6,),
    );
  }
  Widget buildContainer(Widget child){
  return  Container(
        decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(10)
    ),
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    height: 200,
    width: 300,
    child:child);
  }
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    // this varible compare the mealId(user tapped on which meal) and compare the Ids in DUMMY_MEALS if matches stored in variable
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedMeal.title}"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(selectedMeal.imageUrl,fit: BoxFit.cover,),
              ),
               buildSectionTitle(context, "Ingredients"),
               buildContainer(ListView.builder(
                   itemCount: selectedMeal.ingredients.length,
                   itemBuilder: (ctx, index){
                     return Card(
                       color: Theme.of(context).primaryColor,
                       child: Padding(
                           padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                           child: Text(selectedMeal.ingredients[index])
                       ),
                     );
                   }),),
              buildSectionTitle(context, "Steps"),
              buildContainer(ListView.builder(
                itemCount: selectedMeal.steps.length,
                  itemBuilder: (ctx , index){
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text("# ${index + 1}"),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                  }
              ))
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            isFavorite(mealId) ? Icons.star : Icons.star_border
        ),
         onPressed: () {
    toggleFavorite(mealId); // Call the function without returning a value
    },
      ),
    );
  }
}
