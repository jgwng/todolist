import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/Main.dart';
import 'APP_CODE.dart' as globals;

class PassWordScreen extends StatefulWidget{
  PassWordScreen({Key key}) : super(key:key);
  @override
  _PassWordScreenState createState() => _PassWordScreenState();

  }


class _PassWordScreenState extends State<PassWordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _PassWordController = TextEditingController();
  SharedPreferences _preferences;

  @override
  void initState(){
    super.initState();
    _loadCounter();
  }

  _loadCounter() async{
    _preferences = await SharedPreferences.getInstance();
    setState(() {

      _preferences.setString('PassWord',"");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('비밀번호 설정')),
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
                controller: _PassWordController,
                keyboardType: TextInputType.number,

              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      print(_PassWordController.text);
                      _preferences.setString('PassWord',_PassWordController.text);
                    }
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> MyHomePage(title: (globals.MainScreenTitle))));

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