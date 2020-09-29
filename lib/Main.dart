import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/EditToDo.dart';
import 'TODO.dart';
import 'MainScreen_ListView.dart';
import 'package:todolist/TodoDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'APP_CODE.dart' as globals;
import 'package:todolist/PassWordScreen.dart';

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


  Widget _AddButton(){
    return RaisedButton(
      onPressed: () {
       // SharedPreferences preferences = await SharedPreferences.getInstance();
       // String password  = preferences.getString('PassWord');
       // print(password);

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PassWordScreen()
        ),
        );
        setState(() {
        });
      },
      child: Text('AddMemo'),
    );
  }


  Widget _MultiDelete(){
    return RaisedButton(
      onPressed: (){
        Firestore.instance.collection('whattodo').where('checked', isEqualTo :  true).getDocuments().then((snapshot) {
          for(DocumentSnapshot ds in snapshot.documents){
            print(ds.reference);
            Firestore.instance.collection('whattodo').document(ds.documentID).delete();
          }
        });
        setState(() {
        });
      },
      child: Text('MultiDel'),
    ); // 체크된 아이템 모두 삭제
  }
  @override
  Widget build(BuildContext context) {
   return new WillPopScope(child: Scaffold(
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
           _MultiDelete(),
         ],
       )
   ), onWillPop: _onWillPop,);
     //WillPopScope는 앱 종료시에 사용되고 있는 위젯에 적용
    //onWillPop이 해당 앱이 종료시에 사용되는 함수

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
  Future<bool> _onWillPop() async {
    return (
        await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () =>{
                Firestore.instance.collection('whattodo').getDocuments().then((snapshot) {
                  for(DocumentSnapshot ds in snapshot.documents){
                    Firestore.instance.collection('whattodo').document(ds.documentID).updateData({'checked': false},);
                  }
                }),
              Navigator.of(context).pop(true),
            },
            child: new Text('Yes'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
        ],
      ),
    )) ?? false; // 앱 종료시 적용되는 함수
  }
}

