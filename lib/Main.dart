import 'package:flutter/material.dart';
import 'TODO.dart';
import 'package:quiver/iterables.dart';
import 'TodoDetail.dart';

void main() => runApp(TodoAPP());

class TodoAPP extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOAPP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TODOAPP Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  List<TODO> Thingtodos = List.generate(20,(i)=> TODO(i,'ToDo_$i', 'No.$i Thing You Should do'));
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String divider = (((Thingtodos.length)/3).toStringAsFixed(0));
    print(divider);
    var pairs = partition(Thingtodos, int.parse(divider)).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body : ListView.builder(
          itemCount : pairs[_currentIndex].length,itemBuilder: (content,index) {
          return ListTile(title: Text(pairs[_currentIndex][index].title),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailScreen(todo: pairs[_currentIndex][index])
              ),
              );
            },
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onTap,
            currentIndex: _currentIndex,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                title: Text('First'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Second'),
              )
            ]));
  }
}