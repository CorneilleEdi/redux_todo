import 'package:flutter/material.dart';
import 'package:redux_todo/main.dart';

class RemoveItemsWidget extends StatelessWidget {
  final ViewModel model;
  RemoveItemsWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.redAccent,
      child: Text('Delete all items',style: TextStyle(color: Colors.white),),
      onPressed: ()=> model.onRemoveItems(),
    );
  }
}