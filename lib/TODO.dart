import 'package:flutter/material.dart';

class TODO with ChangeNotifier{
  int index;
  String title;
  String WhatToDo;
  bool isChecked = false;

  TODO(this.index,this.title,this.WhatToDo,this.isChecked);

  String get getTitle => title;
  String get getWhatToDO => WhatToDo;
  bool get getIsChecked => isChecked;


  void setChecked(bool checked){
    isChecked = checked;
    notifyListeners();
  }
  void new_title(String text){
    title = text;
    notifyListeners();
  }
  void new_Message(String text){
    WhatToDo = text;
    notifyListeners();
  }
}