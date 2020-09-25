import 'package:flutter/material.dart';
import 'package:todolist/EditToDo.dart';
import 'TODO.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget{
  final TODO todo;
  const DetailScreen({Key key, @required this.todo}) : super(key:key);
  @override
  State createState() => _DetailScreenState();

}


class _DetailScreenState extends State<DetailScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : Text(widget.todo.title)),
      body:Padding(
        padding: EdgeInsets.all(16.0),
        child :GestureDetector(
          onTap:() async {
           await Navigator.push(context,MaterialPageRoute(builder: (context) => EditToDo(todo: widget.todo)));

          setState(() {
          });// 자료

        },
          child: Text(widget.todo.WhatToDo.toString(),
          ),
    ),
    )
    );
  }
}

