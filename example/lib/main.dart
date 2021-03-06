import 'package:flutter/material.dart';
import 'package:retrofit_plugin_example/test_request_service.dart';
import 'network_config_build.dart';

void main() {
  NetWorkConfigBuild.init();
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _data = "";

  //发送数据到原生进行封装
  _post() async {
    PostRequest().execute().then((value) {
      setState(() {
        _data = value;
      });
    });
  }

  _get() async {
    GetRequest().execute().then((value) {
      setState(() {
        _data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: _post, child: Text("Post")),
          TextButton(onPressed: _get, child: Text("Get")),
          Text('请求返回结果：$_data'),
        ],
      ),
    );
  }
}
