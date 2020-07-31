import 'package:flutter/material.dart';
import 'package:resturant_project/routes/filtersScreen/filters_screen.dart';

class MainDrawer extends StatelessWidget {

  Widget _buildListTile(String text, IconData icon , Function tapHandler){
    return   ListTile(
      leading: Icon(icon, size: 26,),title: Text(text, style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 24, fontWeight: FontWeight.bold),),
      onTap: tapHandler
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(height: 120,color: Theme.of(context).accentColor , width: double.infinity, padding: EdgeInsets.all(20), alignment: Alignment.centerLeft,
          child: Text('Cooking Up', style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Theme.of(context).primaryColor
          ),),
          ),
          SizedBox(height: 20,),
          _buildListTile('Meals', Icons.restaurant,(){
            Navigator.of(context).pushReplacementNamed('/');
          }),
          _buildListTile('Filters', Icons.settings, (){
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
