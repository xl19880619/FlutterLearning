import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';

class MyButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap:(){
        LogUtil.v('tapped');
      },
      child: new Container(
        height: 40,
        padding: const EdgeInsets.all(9),
        margin: const EdgeInsets.symmetric(horizontal: 9),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(5),
          color: Colors.lightGreen[500],
        ),
        child: new Center(
          child: new Text("Engage"),
        ),
      ),
    );
  }
}