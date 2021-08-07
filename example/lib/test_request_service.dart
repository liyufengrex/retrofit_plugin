import 'package:retrofit_plugin/retrofit_plugin.dart';

class TestRequest extends RequestBaseLoader<String> {
  ///请求方式 Method.Get || Method.Post
  @override
  Method get method => Method.Get;

  ///网上找的的免费翻译接口
  @override
  String get path => "api/trans.php";

  //请求参数外层是否套 params common，默认为true
  @override
  bool get isDataEncapsulated => false;

  @override
  Map<String, dynamic> get data => {
        "msg": "你好",
      };

  @override
  Map<String, String> get header => {};

  @override
  Future<String> execute() {
    return request().then((value) {
      return value.toString();
    });
  }
}
