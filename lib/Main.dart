import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/EditToDo.dart';
import 'package:todolist/Translation.dart';
import 'TODO.dart';
import 'package:todolist/TodoDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'APP_CODE.dart' as globals;
import 'package:todolist/PassWordScreen.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences preference;

  _loadPreference() async{
    preference = await SharedPreferences.getInstance();
  }

  Widget _AddButton() {
    _loadPreference();
    return RaisedButton(
      onPressed: () {
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // String password  = preferences.getString('PassWord');
        // print(password);

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => EditToDo()
        ),
        );
        setState(() {});
      },
      child: Text('AddMemo'),
    );
  }

  Widget _MultiDelete() {
    return RaisedButton(
      onPressed: () {
        Firestore.instance.collection(globals.DatabaseName).where(
            globals.DB_Check, isEqualTo: true).getDocuments().then((snapshot) {
          for (DocumentSnapshot ds in snapshot.documents) {
            print(ds.reference);
            Firestore.instance.collection(globals.DatabaseName).document(
                ds.documentID).delete();
          }
        });
        setState(() {});
      },
      child: Text('MultiDel'),
    ); // 체크된 아이템 모두 삭제
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(child: Scaffold(
        appBar: AppBar(
            title: Text((DemoLocalizations.of(context).trans(widget.title))),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          PassWordScreen(title: globals.CheckingPassWordTitle)
                  ),
                  );
                },
              )
            ]
        ),
        body: Container(
            child: Column(
              children: <Widget>[
                // Main_ListView(thingtodos: Thingtodos), //가독성을 위한 코드 분리
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection(globals.DatabaseName)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      final documents = snapshot.data.documents;
                      return ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        children:
                        documents.map((doc) => _buildItemWidget(doc)).toList(),
                      );
                    }
                ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        _AddButton(),
                        Spacer(),
                        _MultiDelete()],
                    )
                ),
              ],
            ))
    ),
      onWillPop: _onWillPop,);
    //WillPopScope는 앱 종료시에 사용되고 있는 위젯에 적용
    //onWillPop이 해당 앱이 종료시에 사용되는 함수

  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final memo = TODO(doc[globals.DB_MemoTitle], doc[globals.DB_MemoMessage],
        isChecked: doc[globals.DB_Check], isSecret: doc["Secret"]);
    return Card(
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(204, 153, 255, 0.3)),
        child: ListTile(
          leading: Checkbox(
              value: memo.getIsChecked,
              onChanged: (value) {
                Firestore.instance.collection(globals.DatabaseName).document(
                    doc.documentID).updateData({
                  globals.DB_Check: !doc[globals.DB_Check],
                });
                setState(() {
                  memo.setChecked(value);
                });
              }
          ),
          title: getRandomWidget(memo),
          trailing: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                Firestore.instance.collection(globals.DatabaseName).document(
                    doc.documentID).delete();
                setState(() {});
              }
          ),
        ),),
    );
  }

  Future<bool> _onWillPop() async {
    return (
        await showDialog(
          context: context,
          builder: (context) =>
          new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () =>
                {
                  Firestore.instance.collection(globals.DatabaseName)
                      .getDocuments()
                      .then((snapshot) {
                    for (DocumentSnapshot ds in snapshot.documents) {
                      Firestore.instance.collection(globals.DatabaseName)
                          .document(ds.documentID)
                          .updateData({globals.DB_Check: false},);
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

  Widget getRandomWidget(TODO memo) {

    bool SecretMode = preference.getBool('SecretMode');
    print(SecretMode);
    if(SecretMode){
      if(memo.getIsSecret){
        return Container(
            child : Image.asset('assets/Image/ic_launcher.png', width: 30, height: 50, fit: BoxFit.fill)
        );
      }else{
        return Container(
            child : Text(memo.getTitle)
        );
      }
    }else{
      return Container(
          child : Text(memo.getTitle)
      );
    }
  }
}

