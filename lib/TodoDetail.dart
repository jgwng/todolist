import 'package:flutter/material.dart';
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
        child: Text(todo.WhatToDo), // 아이템의 설명으로 body 구성
      ),
    );
  }

}