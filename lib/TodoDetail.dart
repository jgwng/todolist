import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/EditToDo.dart';
import 'TODO.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget{
  final TODO todo;
  final DocumentSnapshot doc;
  const DetailScreen({Key key, @required this.todo, @required this.doc}) : super(key:key);
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
           final List<TODO> myList  = await Navigator.push(context,MaterialPageRoute(builder: (context) => EditToDo(todo: widget.todo,doc: widget.doc)));

          setState(() {
            print(myList.length);

          });// 자료갱신

        },
          child: Text(widget.todo.WhatToDo.toString(),
          ),
    ),
    )
    );
  }
}

