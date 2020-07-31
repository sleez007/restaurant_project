import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant_project/models/Meal.dart';
import 'package:resturant_project/routes/categoryScreen/categories_screen.dart';
import 'package:resturant_project/routes/favorites_screen.dart';
import 'package:resturant_project/routes/main_drawer.dart';

class BottomTabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  BottomTabScreen(this.favoriteMeals);
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  List<Map<String, Object>> _pages;


  @override
  void initState() {
    super.initState();
    _pages = [
      {'page' : CategoriesScreen(), 'title' : 'categories'},
      {'page' :  FavoritesScreen(widget.favoriteMeals), 'title':'Favorites'}
    ];
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
    CupertinoTabScaffold(
    )
        :
    Scaffold(
      drawer:MainDrawer(),
      appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title'])),
      body:_pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
//        type: BottomNavigationBarType.shifting,

        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category),title: Text('Categories'), backgroundColor:Theme.of(context).primaryColor ),
          BottomNavigationBarItem(icon: Icon(Icons.star),title: Text('Favorites'), backgroundColor:Theme.of(context).primaryColor),
        ],
      ) ,
    );
  }
}
