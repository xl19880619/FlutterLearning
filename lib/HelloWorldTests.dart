import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';

class HelloWorld extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('H W!'),
      ),
      body: new Center(
        child: new Text('Hello World!',textDirection: TextDirection.ltr,),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add',
        child: new Icon(Icons.add),
        onPressed: (){
          _add();
        },
      ),
    );
  }

  _add(){
    
    LogUtil.v("tttttt");
  }
}