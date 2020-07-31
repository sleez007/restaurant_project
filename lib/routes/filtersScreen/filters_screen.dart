import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_project/routes/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen>{
  bool _gluttenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;


  @override
  void initState() {
    super.initState();
    _gluttenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
  }

  Widget _buildSwitchListTile(String text, bool val,String subTitle, Function toggleHandler){
    return  SwitchListTile(title: Text(text),value:val,subtitle: Text(subTitle),
      onChanged: toggleHandler
    );
  }



  @override
  Widget build(BuildContext context) {
    final Widget body = SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your meal selection', style: Theme.of(context).textTheme.title,)
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
               _buildSwitchListTile('Gluten free',  _gluttenFree,'Only include gluten-free-meal', (bool val){setState(() {_gluttenFree = val;});}),
                _buildSwitchListTile('Lactose free',  _lactoseFree,'Only include lactose-free-meal', (bool val){setState(() {_lactoseFree = val;});}),
                _buildSwitchListTile('Vegetarian',  _vegetarian,'Only include vegetarian meals', (bool val){setState(() {_vegetarian = val;});}),
                _buildSwitchListTile('Vegan',  _vegan,'Only include vegan meals', (bool val){setState(() {_vegan = val;});}),
              ],
            )
          )
        ],
      )
    );


    final Widget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle: const Text('Filter screen'),
    )
        : AppBar(
        title:const Text('Filter screen'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.save),onPressed:(){
          final selectedFilters = {
            'gluten' : _gluttenFree,
            'lactose' : _lactoseFree,
            'vegan' : _vegan,
            'vegetarian': _vegetarian
          };
          widget.saveFilters(selectedFilters);
        },)
      ],
    );



    return Platform.isIOS ? CupertinoPageScaffold(
      navigationBar: appBar,
      child: body,
    )
        :
    Scaffold(
      appBar: appBar,
      body:  body ,
      drawer: MainDrawer(),
    );
  }
}
