import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant_project/models/Meal.dart';
import 'package:resturant_project/routes/categorymeal/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);




  @override
  Widget build(BuildContext context) {
    final Widget body = SafeArea(
        child: ListView.builder(itemBuilder: (ctx, index){
          final mm = favoriteMeals[index];
          return MealItem(id:mm.id,title: mm.title,imageUrl:mm.imageUrl,duration: mm.duration,complexity: mm.complexity,affordability: mm.affordability);
        },
          itemCount: favoriteMeals.length,

        )
    );

    if(favoriteMeals.isEmpty){
      return Center(
        child: Text('You have no favorite meals'),
      );
    }else{
      return body;
    }

  }
}
