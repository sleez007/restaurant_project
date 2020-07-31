import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant_project/models/Meal.dart';
import 'package:resturant_project/routes/mealDetail/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id ;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem(
    {
      @required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.duration,
      @required this.complexity,
      @required this.affordability
    }
  );

  String get _complexityText{
    switch(complexity){
      case Complexity.EASY :
        return 'Easy';
        break;
      case Complexity.CHALLENGING:
        return 'Challenging';
        break;
      case Complexity.HARD:
        return 'Hard';
        break;
      default :
        return 'Unknown';
    }
  }

  String get _affordabilityText{
    switch(affordability){
      case Affordability.AFFORDABLE :
        return 'Affordable';
        break;
      case Affordability.LUXURIOUS:
        return 'Luxurious';
        break;
      case Affordability.PRICEY:
        return 'Pricey';
        break;
      default :
        return 'Unknown';
    }
  }

  void _selectMeal(BuildContext context){
      Navigator.of(context).pushNamed(MealDetailScreen.routeName,arguments: {
        'id': id
      }).then((result){
        print(result);
//        if(result!= null){
//          removeItem(result);
//        }

      });
  }

  @override
  Widget build(BuildContext context) {
    final Widget  child = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)) ,
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                child: Image.network(imageUrl, height: 250,width: double.infinity, fit:BoxFit.cover ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child:  Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  color: Colors.black54,
                  child: Text(title,style: TextStyle(fontSize: 26,color: Colors.white),softWrap: true,overflow: TextOverflow.fade),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Platform.isIOS ? CupertinoIcons.time : Icons.schedule),
                    SizedBox(width: 6,),
                    Text('$duration min')
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Platform.isIOS ? CupertinoIcons.collections : Icons.work),
                    SizedBox(width: 6,),
                    Text(_complexityText)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Platform.isIOS ? CupertinoIcons.paw : Icons.attach_money),
                    SizedBox(width: 6,),
                    Text(_affordabilityText)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

    return Platform.isIOS ?
    GestureDetector(
      onTap: ()=>_selectMeal(context),
      child: child
    )
        :
    InkWell(
      onTap: ()=>_selectMeal(context),
      child: child
    );
  }
}
