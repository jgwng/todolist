import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'TODO.dart';
import 'package:todolist/TodoDetail.dart';


class EditToDo extends StatefulWidget {

  EditToDo({Key key, this.todo, this.doc}) : super(key:key);
  final DocumentSnapshot doc;
  final TODO todo;
  @override
  _EditTODOState createState() => _EditTODOState();

}

class _EditTODOState extends State<EditToDo>{

  final _formKey = GlobalKey<FormState>();
  final _TitleController = TextEditingController();//Title텍스트 내용 캡쳐
  final _MessageController = TextEditingController();

  //Message텍스트 내용 캡쳐

  @override
  void dispose() {
    _TitleController.dispose();
    _MessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.doc == null){
      _TitleController..text = "";//해당 TextEditForm 초기값 설정
      _MessageController..text = "";//해당 TextEditForm 초기값 설정
    }
    else{
      _TitleController..text = widget.todo.title;//해당 TextEditForm 초기값 설정
      _MessageController..text = widget.todo.WhatToDo;//해당 TextEditForm 초기값 설정
    }


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
                      // _TitleController.text / _MessageController.text
                      if((_TitleController.text != null && _MessageController.text != null)
                      & (widget.doc == null))
                    {
                        Firestore.instance.collection('whattodo').add({'title' : _TitleController.text,
                          'message' : _MessageController.text,'checked' : false});
                        widget.todo.new_title(_TitleController.text);
                        widget.todo.new_Message(_MessageController.text);

                      } else if (widget.doc != null){
                        Firestore.instance.collection('whattodo').document(widget.doc.documentID).updateData({'title' : _TitleController.text,
                            'message' : _MessageController.text});
                        widget.todo.new_title(_TitleController.text);
                        widget.todo.new_Message(_MessageController.text);
                      }


                    }

                    Navigator.of(context).pop(widget.todo);
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