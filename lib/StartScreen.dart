import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Main.dart';
import 'PassWordScreen.dart';

void main() => runApp(TODOLIST());

class TODOLIST extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO_LIST',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,

      ),

      home: StartScreen(),
    );
  }
}

  class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
  }

class _StartScreenState extends State<StartScreen>{
  @override
  void initState(){
    super.initState();
    checkFirstSeen();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('isFirstTime') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new  MyHomePage(title: 'TODOAPP Home Page')));
    } else {
      await prefs.setBool('isFirstTime', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new PassWordScreen()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new Text('Loading...')
      ),
    );
  }

}

