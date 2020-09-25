import 'package:flutter/material.dart';

class TODO with ChangeNotifier{
  int index;
  String title;
  String WhatToDo;

  TODO(this.index,this.title,this.WhatToDo);
  String get getTitle => title;
  String get getWhatToDO => WhatToDo;
  void new_title(String text){
    title = text;
    notifyListeners();
  }
  void new_Message(String text){
    WhatToDo = text;
    notifyListeners();
  }
}