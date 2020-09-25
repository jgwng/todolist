import 'package:flutter/material.dart';
import 'package:todolist/EditToDo.dart';
import 'TODO.dart';
import 'TodoDetail.dart';
import 'APPCODE.dart';

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

  List<TODO> Thingtodos = List.generate(5,(i)=> TODO(i,APPCODE().def_Title(i), 'No.$i Thing You Should do'));
  var isChecked = false;


  AddTodo(BuildContext context) async{
    Thingtodos.add(TODO(Thingtodos.length, "", ""));
    final result = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => EditToDo(todo: Thingtodos[Thingtodos.length-1])
    ),
    );
    setState(() {

    });
  }

  Widget _ListView(){
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount : Thingtodos.length,itemBuilder: (content,index) {
      return ListTile(
        leading: Checkbox(
          value: false,
          onChanged:(value){
            setState(() {
              isChecked = value;
            });
          }
        ),
        title: Text(Thingtodos[index].title),
        onTap: () async{
          await Navigator.push(context, MaterialPageRoute(

              builder: (context) => DetailScreen(todo: Thingtodos[index])
          ),
          );
          setState(() {

          });
        },
        trailing: IconButton(
          icon:Icon(Icons.delete_forever),
          onPressed: (){
            Thingtodos.removeAt(index);
            setState(() {

            });
          }
        ),
      );

    });
  }

  Widget _AddButton(){
    return RaisedButton(
      onPressed: (){
        AddTodo(context);
      },
      child: Text('AddMemo'),
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body : Column(
          children: <Widget>[
            _ListView(),
            _AddButton(),
          ],
        )
   );



  }
}