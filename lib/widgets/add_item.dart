import 'package:flutter/material.dart';
import 'package:redux_todo/main.dart';

class AddItemWidget extends StatefulWidget {
  final ViewModel model;
  AddItemWidget(this.model);

  _AddItemWidgetState createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:16.0,right: 16.0, top: 16.0),
      child: TextField(
        controller: _controller,
        decoration:  InputDecoration(
          hintText: 'add an item',
          filled: true
        ),
        onSubmitted: (String s){
          widget.model.onAddItem(s);
          _controller.text = '';
        },
      ),
    );
  }
}