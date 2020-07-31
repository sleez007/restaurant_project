import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant_project/routes/categoryScreen/categories_screen.dart';
import 'package:resturant_project/routes/favorites_screen.dart';


/**
 * THIS EXAMPLE IS FOR TOP TAB IE. FUSED WITH THE APPBAR
 */
class TabScreen  extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
//    return Platform.isIOS CupertinoPageScaffold(): Scaffold();
    return DefaultTabController(length: 2, initialIndex: 0, child: Scaffold(
      appBar: AppBar(title: const Text('Meals'), bottom: TabBar(tabs: <Widget>[
        Tab(icon: Icon(Icons.category),text: 'Categories',),
        Tab(icon: Icon(Icons.star),text: 'Favorites',)
      ],
      )
        ,) ,
      body: TabBarView(
        children: <Widget>[
         // CategoriesScreen(),FavoritesScreen()
        ],
      ),
    ));
  }
}
