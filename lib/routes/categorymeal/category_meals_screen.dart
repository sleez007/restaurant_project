import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant_project/dummy_data.dart';
import 'package:resturant_project/routes/categorymeal/widgets/meal_item.dart';

class CategoryMealsScreen  extends StatelessWidget {
  static const String routeName = '/category-meals';

//  final String categoryId;
//  final String categoryTitle;
//
//  CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];

    final categoryMeals = DUMMY_MEALS.where((meal){
      return meal.categories.contains(categoryId);
    }).toList();

    final Widget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle:  Text(categoryTitle),
    )
        : AppBar(
      title:Text(categoryTitle),
    );

    final Widget body = SafeArea(
      child: ListView.builder(itemBuilder: (ctx, index){
        final mm = categoryMeals[index];
          return MealItem(id:mm.id,title: mm.title,imageUrl:mm.imageUrl,duration: mm.duration,complexity: mm.complexity,affordability: mm.affordability);
      },
        itemCount: categoryMeals.length,

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
