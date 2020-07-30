import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant_project/routes/categoryScreen/widgets/category_item.dart';
import 'package:resturant_project/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  final Widget appBar = Platform.isIOS
      ? CupertinoNavigationBar(
          middle: const  Text("Restaurant App"),
        )
      : AppBar(
          title: const Text("Restaurant App"),
        );
  final Widget body = SafeArea(
      child: GridView(
        padding: const EdgeInsets.all(15),
    children: DUMMY_CATEGORIES
        .map((catData) => CategoryItem(catData.id, catData.title, catData.color))
        .toList(),
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20),
  ));
  @override
  Widget build(BuildContext context) {
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
