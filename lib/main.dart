import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';

import 'StatefulClass.dart';
import 'HelloWorldTests.dart';
import 'LayoutTests.dart';
import 'GestureTests.dart';
import 'IncreaseTests.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    LogUtil.init(isDebug: true);
    return new MaterialApp (
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new ListDemo(),
      // home: new Scaffold(
      //   appBar: new AppBar(
      //     title: new Text('Welcome to Flutter'),    
      //   ),
      //   body: new Center(
      //     // child: new Text('Hello World')
      //     child: new RandomWords(),
      //   )
      // ),
    );
  }
}

class ListDemo extends StatelessWidget {
  final _titles = <String>[
    'favorite', 'layout', 'gesture', 'increment','otherssss'
  ];
  Widget build(BuildContext context){
        return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          // new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
          // new IconButton(icon: new Icon(Icons.book), onPressed: _pushSaved),
        ],
      ),
      body: new ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _titles.length,
        itemBuilder: (context, i) {
          // if (i >= _titles.length) {
          //   return null;
          // }
          return new ListTile(
            title: new Text(_titles[i]),
            onTap:(){
              _push(context,_titles[i]);
            },
          );
        },
      ),
    );
  }

  // Widget _buildRow(String title) {
  //   return new ListTile(
  //     title: new Text(title),
  //     onTap:(){
  //       _push(title);
  //     },
  //   );
  // }

  void _push(BuildContext context, String title) {
    // navigatorKey.currentState..push(
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context){
          switch (title) {
            case 'favorite': return RandomWords();
            case 'layout': return LayoutTests();
            case 'gesture': return MyButton();
            case 'increment': return Counter();
            default: return HelloWorld();
          }
          // if (title == 'favorite') {
          //   return RandomWords();  
          // } else if (title == 'layout') {
          //   return LayoutTests();
          // } 
          // return HelloWorld();
        }
      ),
    );
  }
} 

