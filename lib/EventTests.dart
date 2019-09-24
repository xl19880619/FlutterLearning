import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TitleEvent extends StatefulWidget {
  @override
  _TitleEventState createState() => new _TitleEventState();
}

class _TitleEventState extends State<TitleEvent> {
  // 注册一个通知
  static const EventChannel eventChannel =
      const EventChannel('com.pages.your/native_post');

  // 渲染前的操作，类似viewDidLoad
  @override
  void initState() {
    super.initState();
  }

  String naviTitle = '你好，FLUTTER';
  // 回调事件
  void _onEvent(Object event) {
    setState(() {
      naviTitle = event.toString();
    });
  }

  // 错误返回
  void _onError(Object error) {}

  _refresh() {
// 监听事件，同时发送参数12345
    eventChannel
        .receiveBroadcastStream(12345)
        .listen(_onEvent, onError: _onError);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(naviTitle),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.refresh), onPressed: _refresh),
        ],
      ),
      body: new Center(
        child: Text('Event Tests'),
      ),
    );
  }
}
