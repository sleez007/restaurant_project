import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_project/dummy_data.dart';
import 'package:resturant_project/models/Meal.dart';
import 'package:resturant_project/routes/bottom_tab_screen.dart';
import 'package:resturant_project/routes/categoryScreen/categories_screen.dart';
import 'package:resturant_project/routes/categorymeal/category_meals_screen.dart';
import 'package:resturant_project/routes/filtersScreen/filters_screen.dart';
import 'package:resturant_project/routes/mealDetail/meal_detail_screen.dart';
import 'package:resturant_project/routes/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }


}

class _MyAppState extends State<MyApp>{
  Map<String , bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String , bool> filteredData ){
    setState(() {
      _filters = filteredData;
      _availableMeals = DUMMY_MEALS.where((meal){
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
   final existingIndex = _favoriteMeals.indexWhere((meal)=>meal.id == mealId);
   if(existingIndex >= 0){
     setState(() {
       _favoriteMeals.removeAt(existingIndex);
     });
   }else{
     setState(() {
       _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal)=> meal.id == mealId));
     });
   }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal)=>meal.id == id);
  }

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
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName: (context)=>FiltersScreen(_setFilters, _filters)
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
        '/': (context) =>  BottomTabScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName: (context)=>FiltersScreen(_setFilters, _filters)
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



