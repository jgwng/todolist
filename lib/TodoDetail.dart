import 'package:flutter/material.dart';
import 'package:todolist/EditToDo.dart';
import 'TODO.dart';

class DetailScreen extends StatelessWidget{
  final TODO todo;
  const DetailScreen({Key key, @required this.todo}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : Text(todo.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            _navigateAndDisplaySelection(context);
          },

          child: Text(todo.WhatToDo),
        ), // 아이템의 설명으로 body 구성
      ),
    );
  }
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditToDo(todo: todo)),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("555555")));
  }

}