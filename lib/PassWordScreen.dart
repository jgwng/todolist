import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/Main.dart';
import 'package:todolist/Translation.dart';
import 'APP_CODE.dart' as globals;

class PassWordScreen extends StatefulWidget{
  PassWordScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PassWordScreenState createState() => _PassWordScreenState();

  }


class _PassWordScreenState extends State<PassWordScreen> {
  final _passwordformKey = GlobalKey<FormState>();
  final _PassWordController = TextEditingController();
  SharedPreferences _preferences;

  _loadCounter() async{
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _loadCounter();
    return Scaffold(
      appBar: AppBar(title: Text(DemoLocalizations.of(context).trans(widget.title))),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _passwordformKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                ),
                controller: _PassWordController,
                keyboardType: TextInputType.number,
                validator: (value){

                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: () {
                    if (_passwordformKey.currentState.validate()) {
                      if(_preferences.getString(globals.PassWord) == null){

                        _preferences.setString(globals.PassWord, _PassWordController.text);
                        _preferences.setBool(globals.checkFirstTime,false);

                      }
                      else if(_preferences.getString(globals.PassWord) ==  _PassWordController.text){
                        bool currentMode = _preferences.getBool('SecretMode');
                        currentMode = !currentMode;
                        _preferences.setBool('SecretMode',currentMode);
                      }
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> MyHomePage(title: (globals.MainScreenTitle))));
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