import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/EditToDo.dart';
import 'package:todolist/Translation.dart';
import 'TODO.dart';
import 'APP_CODE.dart' as globals;
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget{
  final TODO todo;
  final DocumentSnapshot doc;
  final String title;
  const DetailScreen({Key key, this.title, @required this.todo, @required this.doc}) : super(key:key);
  @override
  State createState() => _DetailScreenState();

}


class _DetailScreenState extends State<DetailScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : Text(DemoLocalizations.of(context).trans(widget.title))),
      body:Padding(
        padding: EdgeInsets.all(16.0),
        child :GestureDetector(
          onTap:() async {
           var result = await Navigator.push(context,MaterialPageRoute(builder: (context) => EditToDo(title : globals.EditingMemo,todo: widget.todo,doc: widget.doc)));

          setState(() {
          });// 자료갱신

        },
          child: Text(widget.todo.WhatToDo.toString(),
          ),
    ),
    )
    );
  }
}

