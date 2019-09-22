import 'package:flutter/material.dart';

class Counter extends StatefulWidget{
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter>{
  
  int _counter = 0;

  void _increment(){
    setState((){
      _counter ++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      backgroundColor: Colors.white,
      children: <Widget>[
        new RaisedButton(
          onPressed: _increment,
          child: new Text('Increment'),
        ),
        new Text('Count: $_counter'),
      ],
    );
  }
}