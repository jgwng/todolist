import 'package:flutter/material.dart';
import 'package:todolist/BTNavi_first.dart';

void main() {
  runApp(TodoAPP());
}

class TodoAPP extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'TodoApp',
      theme: ThemeData(
        primaryColor: Colors.purple,),
      home : BTnavi_first(),
    );
  }
}