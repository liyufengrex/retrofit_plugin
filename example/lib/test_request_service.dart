import 'package:retrofit_plugin/retrofit_plugin.dart';

class GetRequest extends RequestBaseLoader<String> {
  @override
  Method get method => Method.Get;

  @override
  String get path => "api/trans.php";

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

class PostRequest extends RequestBaseLoader<String> {
  @override
  String get domainKey => "second";

  @override
  Method get method => Method.Post;

  @override
  String get path => "likePoetry";

  @override
  Map<String, dynamic> get data => {
        "name": "李白",
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
