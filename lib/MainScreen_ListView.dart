import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'TODO.dart';
import 'TodoDetail.dart';

class Main_ListView extends StatefulWidget{
  final List<TODO> thingtodos;
  Main_ListView({@required this.thingtodos});//필수 입력 인수 표시




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainListViewState();
  }

}

class MainListViewState extends State<Main_ListView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.thingtodos.length, itemBuilder: (content, index) {
      return ListTile(
        leading: Checkbox(
            value: widget.thingtodos[index].getIsChecked,
            onChanged: (value) {
              setState(() {
                widget.thingtodos[index].setChecked(value);
              });
            }
        ),
        title: Text(widget.thingtodos[index].title),
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(

              builder: (context) => DetailScreen(todo: widget.thingtodos[index])
          ),
          );
          setState(() {

          });
        },
        trailing: IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              widget.thingtodos.removeAt(index);
              setState(() {});
            }
        ),
      );
    });
  }
}