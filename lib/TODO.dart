import 'package:flutter/material.dart';

class TODO with ChangeNotifier{
  int index;
  String title;
  String WhatToDo;
  bool isChecked,isSecret = false;

  TODO(this.title,this.WhatToDo,{this.isChecked=false, this.isSecret=false});

  String get getTitle => title;
  String get getWhatToDO => WhatToDo;
  bool get getIsChecked => isChecked;
  bool get getIsSecret => isSecret;

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
  void setSecret(bool secret){
    isSecret = secret;
    notifyListeners();
  }
}