import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_project/dummy_data.dart';
import 'package:resturant_project/models/Meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  static const String routeName ='/meal-detial';

  Widget _buildSectionTitle(String text, BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.title),
    );
  }

  Widget _buildContainer(Widget child){
    return
    Container(
      height:200,
      width:300,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: child
    );
  }

  Widget _buildStepListItem(Meal selectedMeal,int index, BuildContext context){
    return Platform.isIOS ?
    Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Container(
                  child: CircleAvatar(child: Text('# ${index+1}')),
                ),
                SizedBox(width: 10),
                Container(
                  width: 200,
                  child: Text(selectedMeal.steps[index], style: Theme.of(context).textTheme.body2 ,),
                ),
              ],
            ),
          ),
          Divider()
        ]
    )
        :

   Column(
     children: <Widget>[
       ListTile(
         leading: CircleAvatar(child: Text('# ${index+1}')),
         title: Text(selectedMeal.steps[index]),
       ),
       Divider()
     ],
      );
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = (ModalRoute.of(context).settings.arguments as Map<String, String>)['id'];
    final selectedMeal = DUMMY_MEALS.firstWhere((meal)=>meal.id == mealId);
    final Widget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle:  Text(selectedMeal.title),
    )
        : AppBar(
      title:Text(selectedMeal.title),
    );

    final Widget  body = SafeArea(
      child:SingleChildScrollView(child:Column(
        children: <Widget>[
          Container(
            height:300,
            width: double.infinity,
            child: Image.network(selectedMeal.imageUrl,fit: BoxFit.cover),
          ),
          _buildSectionTitle('Ingredients', context),
       _buildContainer( ListView.builder(
           itemCount: selectedMeal.ingredients.length,
           itemBuilder: (ctx, index)=>Card(
               color: Theme.of(context).accentColor,
               child: Padding(
                 padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                 child: Text(selectedMeal.ingredients[index]),
               )
           )),),
          _buildSectionTitle('Steps', context),
          _buildContainer(
            ListView.builder(itemBuilder: (ctx, index){
              return  _buildStepListItem(selectedMeal, index, context);
            }, itemCount: selectedMeal.steps.length,)
          )
        ],
      ) ,
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
      child: body,
      navigationBar: appBar,
    )
        : Scaffold(
      body: body,
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId) ?Icons.favorite: Icons.favorite_border),
        onPressed: ()=>toggleFavorite(mealId)
      ),
    );
  }
}
