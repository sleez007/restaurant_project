import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant_project/models/Meal.dart';
import 'package:resturant_project/routes/categorymeal/widgets/meal_item.dart';

class CategoryMealsScreen  extends StatefulWidget {
  static const String routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);


  @override
  _CategoryMealState createState() {
    return _CategoryMealState();
  }
}

class _CategoryMealState extends State<CategoryMealsScreen>{

  String categoryTitle;
  List<Meal> displayedMeals;

  void _removeMeal(String mealId){
    setState(() {
       displayedMeals.removeWhere((meal)=>meal.id == mealId);
    });
  }

  bool loadedInitData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!loadedInitData){
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal){
        return meal.categories.contains(categoryId);
      }).toList();
      loadedInitData = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    final Widget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle:  Text(categoryTitle),
    )
        : AppBar(
      title:Text(categoryTitle),
    );

    final Widget body = SafeArea(
        child: ListView.builder(itemBuilder: (ctx, index){
          final mm = displayedMeals[index];
          return MealItem(id:mm.id,title: mm.title,imageUrl:mm.imageUrl,duration: mm.duration,complexity: mm.complexity,affordability: mm.affordability);
        },
          itemCount: displayedMeals.length,

        )
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
      child: body,
      navigationBar: appBar,
    )
        : Scaffold(
      body: body,
      appBar: appBar,
    );
  }
}
