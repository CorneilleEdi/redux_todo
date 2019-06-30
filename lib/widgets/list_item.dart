import 'package:flutter/material.dart';
import 'package:redux_todo/main.dart';
import 'package:redux_todo/model/model.dart';

class ItemListWidget extends StatelessWidget {
  final ViewModel model;
  ItemListWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: model.items.map((Item item) {
        var listTile = ListTile(
          title: Text(item.body),
          leading: IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
            ),
            onPressed: () => model.onRemoveItem(item),
          ),
          trailing: Checkbox(
            value: item.completed,
            onChanged: (b) {
              model.onCompleted(item);
            },
          ),
        );
        return listTile;
      }).toList(),
    );
  }
}
