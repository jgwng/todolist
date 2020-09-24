import 'package:flutter/material.dart';
import 'TODO.dart';
import 'TodoDetail.dart';


class BTnavi_first extends StatelessWidget{
  List<TODO> Thingtodos = List.generate(20,(i)=> TODO('ToDo_$i', 'No.$i Thing You Should do'));
  TODO todo;
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar:AppBar(title: Text('Todos')),
          body : ListView.builder(itemCount : Thingtodos.length,
          itemBuilder: (content,index){
            return ListTile(
              title:Text(Thingtodos[index].title),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder :(context)=> DetailScreen(todo : Thingtodos[index])));
            },
            );
          },)
        );
  }
}