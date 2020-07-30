import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant_project/routes/categorymeal/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id ;

  CategoryItem(this.id,this.title, this.color);

  void _selectCategory(BuildContext context){
//    Navigator.of(context).push(
//      Platform.isIOS? CupertinoPageRoute(
//        builder: (_)=> CategoryMealsScreen(id,title)
//      ) : MaterialPageRoute(
//        builder: (_)=> CategoryMealsScreen(id,title)
//      )
//    );
    Navigator.of(context).pushNamed(CategoryMealsScreen.routeName,arguments: {
      'id': id,
      'title' : title
    });
  }

  @override
  Widget build(BuildContext context) {
    final body = Container(
      padding: const EdgeInsets.all(15),
      child: Text(title, style: Theme.of(context).textTheme.title,),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color.withOpacity(.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(15)
      ),
    );

    return Platform.isIOS ?
    GestureDetector(
      onTap:()=> _selectCategory(context),
      child:body ,
    )
        :
    InkWell(
      onTap:()=> _selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child:body ,
    );

  }
}
