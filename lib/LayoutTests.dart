import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget{
  MyAppBar({this.title});
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 84,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      child: new Row(
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: Navigator.of(context).pop,
            ),
          new Expanded(
            child: title
          ),
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          )
        ],
      ),
    );
  }
}

class LayoutTests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Text(
              'LayoutTestsDemo',
              style: Theme.of(context).primaryTextTheme.title,
            )
          ),
          new Expanded(
            child: new Center(
              child: new Text('Hello Layout'),
            ),
          ),
        ],
      ),
    );
  }
}