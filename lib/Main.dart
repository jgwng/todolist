import 'package:flutter/material.dart';
import 'package:todolist/EditToDo.dart';
import 'TODO.dart';
import 'MainScreen_ListView.dart';
import 'package:todolist/TodoDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'APP_CODE.dart' as globals;


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

  // List<TODO> Thingtodos = List.generate(5,(i)=> TODO(i,globals.Title+'$i', '$i'+globals.Message,false));

  Widget _AddButton(){
    return RaisedButton(
      onPressed: (){

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => EditToDo()
        ),
        );

        setState(() {

        });
      },

      child: Text('AddMemo'),
    );
  }

  // AddTodo(BuildContext context) async{
  //
  //   final result = await Navigator.push(context, MaterialPageRoute(
  //       builder: (context) => EditToDo(todo: Thingtodos.last)
  //   ),
  //   );
  //   if(result == null){
  //     Thingtodos.removeLast();
  //     print(Thingtodos.length);
  //   }
  //
  // }

  // Widget _MultiDelete(){
  //   return RaisedButton(
  //     onPressed: (){
  //       int size = Thingtodos.length;
  //       for(int i =0; i<size;i++){
  //         if(Thingtodos[i].getIsChecked == true){
  //           Thingtodos.removeAt(i);
  //
  //           i--;
  //           size = Thingtodos.length;
  //         }
  //       }
  //       setState(() {
  //       });
  //     },
  //     child: Text('MultiDel'),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body : Column(
          children: <Widget>[
            // Main_ListView(thingtodos: Thingtodos), //가독성을 위한 코드 분리
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('whattodo').snapshots(),
              builder:(context, snapshot){
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                final documents = snapshot.data.documents;

                return Expanded(
                  child: ListView(
                    children:
                   documents.map((doc) => _buildItemWidget(doc)).toList(),
                    )
                  );
              }
            ),
            _AddButton(),
            // _MultiDelete(),
          ],
        )
   );

  }
  Widget _buildItemWidget(DocumentSnapshot doc) {
    final memo = TODO(doc['title'], doc['message'],isChecked : doc['checked']);

    return ListTile(
      leading:  Checkbox(
          value: memo.getIsChecked,
          onChanged: (value) {
            Firestore.instance.collection('whattodo').document(doc.documentID).updateData({
              'checked': !doc['checked'],
            });
            setState(() {

              memo.setChecked(value);
            });
          }
    ),
      title: Text(memo.title),
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(

            builder: (context) => DetailScreen(todo: memo,doc: doc)
        ),
        );
        setState(() {

        });
      },
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: (){
            Firestore.instance.collection('whattodo').document(doc.documentID).delete();
         setState(() {});
            }
      ),
    );
  }



}