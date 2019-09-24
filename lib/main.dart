import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';

import 'StatefulClass.dart';
import 'HelloWorldTests.dart';
import 'LayoutTests.dart';
import 'GestureTests.dart';
import 'IncreaseTests.dart';
import 'EventTests.dart';
import 'NetworkTests.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

// void main() => runApp(new MyApp());

void main() => runApp(_widgetForRoute(window.defaultRouteName));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'myApp':
      return MyApp();
    case 'home':
      return RandomWords();
    default:
      // return MyApp();
    return Center(
      child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    LogUtil.init(isDebug: true);
    return new MaterialApp(
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
    'helloworld',
    'favorite',
    'layout',
    'gesture',
    'increment',
    'event',
    'network',
    'otherssss'
  ];


  // 创建一个给native的channel (类似iOS的通知）
  static const methodChannel = const MethodChannel('com.pages.your/native_get');

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                methodChannel.invokeMethod('toNativePop');
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: <Widget>[
          // new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
          // new IconButton(icon: new Icon(Icons.book), onPressed: _pushSaved),
        ],
      ),
      body: new ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _titles.length,
        itemBuilder: (context, i) {
          return new ListTile(
            title: new Text(_titles[i]),
            onTap: () {
              _push(context, _titles[i]);
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
      new MaterialPageRoute(builder: (context) {
        switch (title) {
          case 'helloworld':
            return HelloWorld();
          case 'favorite':
            return RandomWords();
          case 'layout':
            return LayoutTests();
          case 'gesture':
            return MyButton();
          case 'increment':
            return Counter();
          case 'event':
            return TitleEvent();
          case 'network':
            return MyHomePage();
          default:
            return HelloWorld();
        }
        // if (title == 'favorite') {
        //   return RandomWords();
        // } else if (title == 'layout') {
        //   return LayoutTests();
        // }
        // return HelloWorld();
      }),
    );
  }
}
