import 'dart:collection';
import 'dart:convert' as JSON;
import 'channel/message_channel_tool.dart';
import 'retrofit_plugin.dart';

///调用原生网络库
abstract class RequestBaseLoader<T> {
  ///请求path
  String get path;

  /// Post 或者 Get
  Method get method;

  ///netConfig对应的key
  String get domainKey => null;

  ///post传参
  Map<String, dynamic> get data => HashMap();

  ///header
  Map<String, String> get header => HashMap();

  NetWorkConfig _getConfig() {
    return NetWorkConfigManager.getConfig(domainKey: domainKey);
  }

  ///获取域名地址
  String _getBaseUrl() {
    return _getConfig().baseUrl;
  }

  ///拦截器
  NetworkIntercept get intercept => _getConfig().intercept;

  ///获取请求头
  Map<String, String> _getHeaders() {
    Map<String, String> headers = _getConfig().headers;
    if (headers == null) {
      headers = Map();
    }
    if (header != null && header.length > 0) {
      header.forEach((key, value) {
        headers.putIfAbsent(key, () => value);
      });
    }
    return headers;
  }

  ///获取请求传参
  Map<String, dynamic> _getParams() {
    return data ?? {};
  }

  Request _createReq() {
    return Request(
      method: method == Method.Post ? "Post" : "Get",
      baseUrl: _getBaseUrl(),
      pathUrl: path,
      headers: _getHeaders(),
      params: _getParams(),
    );
  }

  ///请求结果为 map
  Future<Map<String, dynamic>> request() async {
    Request _request = _createReq();
    //添加 request 拦截器
    if (intercept != null) {
      intercept.onRequest(_request);
    }
    Response response = await NativeRequestTool.doRequest(_request);
    //添加 response 拦截器
    if (intercept != null) {
      intercept.onResponse(response);
    }
    if (response.success) {
      Map<String, dynamic> result;
      try {
        result = JSON.jsonDecode(response.data);
      } catch (_) {
        result = {"response": response.data};
      }
      return result;
    } else {
      //网络层错误
      if (intercept != null) {
        intercept.onError(response.data);
      }
      throw Exception(response.data);
    }
  }

  Future<T> execute();
}

enum Method {
  Post,
  Get,
}
