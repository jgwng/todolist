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
  final _TitleController = TextEditingController();//입력받는 텍스트 관리
  final _MessageController = TextEditingController();//입력받는 텍스트 관리

  //Message텍스트 내용 캡쳐

  @override
  void dispose() {
    _TitleController.dispose();
    _MessageController.dispose();
    super.dispose();
  } // 화면이 pop될때 같이 해제를 시켜주어야 함

  @override
  Widget build(BuildContext context) {
    _TitleController..text =(widget.doc== null) ? "" : widget.todo.title; // text 입력부분 초기값 설정
    _MessageController..text =(widget.doc== null) ? "" : widget.todo.WhatToDo; // text 입력부분 초기값 설정

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

              ), //(Title 입력 부분)
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: _MessageController,
                keyboardType: TextInputType.number,
              ),//(Message 입력 부분)
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: (){
                    if (_formKey.currentState.validate()){
                    if(_TitleController.text == "" && _MessageController.text ==""){
                    }//제목과 내용부분 모두가 빈칸 일 경우
                    else{
                      if(widget.doc != null)// 기존에 저장한 메모를 수정하려 하는 경우
                      {
                        Firestore.instance.collection('whattodo').document(widget.doc.documentID).updateData({'title' : _TitleController.text,
                        'message' : _MessageController.text});

                      widget.todo.new_title(_TitleController.text);
                      widget.todo.new_Message(_MessageController.text);
                      }
                      else{
                        Firestore.instance.collection('whattodo').add({'title' : _TitleController.text,
                          'message' : _MessageController.text,'checked' : false});
                        }// DB에 새로운 메모를 추가하는 경우
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