import 'package:flutter/material.dart';
import 'TODO.dart';
import 'package:todolist/TodoDetail.dart';


class EditToDo extends StatefulWidget {
  EditToDo({Key key, this.todo}) : super(key:key);
  final TODO todo;
  @override
  _EditTODOState createState() => _EditTODOState();

}

class _EditTODOState extends State<EditToDo>{

  final _formKey = GlobalKey<FormState>();
  final _TitleController = TextEditingController();//Title텍스트 내용 캡쳐
  final _MessageController = TextEditingController();//Message텍스트 내용 캡쳐

  @override
  void dispose() {
    _TitleController.dispose();
    _MessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _TitleController..text = widget.todo.title;//해당 TextEditForm 초기값 설정
    _MessageController..text = widget.todo.WhatToDo;//해당 TextEditForm 초기값 설정

    return Scaffold(
      appBar: AppBar(title: Text('Edit WhatToDo')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: _TitleController,
                keyboardType: TextInputType.number,

              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: _MessageController,
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: (){
                    if (_formKey.currentState.validate()){
                      widget.todo.new_title(_TitleController.text);
                      widget.todo.new_Message(_MessageController.text);
                      Navigator.pop(context,widget.todo,
                      );
                    }
                  },
                  child: Text('저장'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



}