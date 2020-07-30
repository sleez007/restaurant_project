import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_project/routes/categoryScreen/categories_screen.dart';
import 'package:resturant_project/routes/categorymeal/category_meals_screen.dart';
import 'package:resturant_project/routes/mealDetail/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
    CupertinoApp(
      title:'Nova Kitchens',
//      home: CategoriesScreen() ,
      theme: CupertinoThemeData(
        primaryContrastingColor: Colors.pink,
        textTheme: const CupertinoTextThemeData(
          textStyle: const TextStyle(fontFamily: 'Raleway')
        )
      ),
      //initialRoute: '/',
      routes: {
        '/': (context) =>  CategoriesScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen()
      },
      onGenerateRoute: (settings){
        return CupertinoPageRoute(
            builder: (context) => CategoriesScreen()
        );
      },
      onUnknownRoute:(settings){
        return MaterialPageRoute(
            builder:  (context) => CategoriesScreen()
        );
      },
    )
        :
    MaterialApp(
      title: 'Nova Kitchens',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 244, 229, 1),
        fontFamily:  'Raleway',
        textTheme:  ThemeData.light().textTheme.copyWith(
          body1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)), body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          title: const TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold)
        )
      ),
      //home: CategoriesScreen(),
        routes: {
          '/': (context) =>  CategoriesScreen(),
          CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
          MealDetailScreen.routeName: (context) => MealDetailScreen(),
        },
      onGenerateRoute: (settings){
        print(settings);
        return MaterialPageRoute(
          builder:  (context) => CategoriesScreen()
        );
      },
      onUnknownRoute:(settings){
        return MaterialPageRoute(
            builder:  (context) => CategoriesScreen()
        );
      } ,
    );
  }
}



