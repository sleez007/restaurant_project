import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {

  static const String routeName ='/meal-detial';
  @override
  Widget build(BuildContext context) {
    final String mealId = (ModalRoute.of(context).settings.arguments as Map<String, String>)['id'];
    final Widget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle: const  Text("Restaurant App"),
    )
        : AppBar(
      title: const Text("Restaurant App"),
    );

    final Widget  body = Center(
      child: Text(mealId, style: TextStyle(color: Colors.purple),),
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
