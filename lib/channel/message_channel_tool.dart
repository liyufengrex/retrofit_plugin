import 'dart:async';
import 'dart:collection';

import 'package:flutter/services.dart';

class NativeRequestTool {
  // BasicMessageChannel 的名称要与 native 端相对应
  static const BasicMessageChannel _messageChannel =
      const BasicMessageChannel('retrofitRequest', StandardMessageCodec());

  static Future<Response> doRequest(Request param) async {
    //我们规范参数类型为 map
    return _messageChannel
        .send(param.toJson())
        .then((value) => Response.fromNative(value));
  }
}

// 我们规定的传参模型范式
class Request {
  final String method;
  final String baseUrl;
  final String pathUrl;
  final Map<String, String> headers;
  final Map<String, dynamic> params;

  Request({
    this.method,
    this.baseUrl,
    this.pathUrl,
    this.headers,
    this.params,
  }) : assert(
          baseUrl != null,
          pathUrl != null,
        );

  HashMap<String, dynamic> toJson() {
    return new HashMap<String, dynamic>()
      ..['method'] = method
      ..['baseUrl'] = baseUrl
      ..['pathUrl'] = pathUrl
      ..['headers'] = headers ?? {}
      ..['params'] = params ?? {};
  }
}

// 我们规定的回参模型范式
class Response {
  final bool success;
  final String data; //data为请求返回结果

  Response({this.success, this.data});

  factory Response.fromNative(dynamic result) {
    return Response(
      success: result['success'],
      data: result['data'],
    );
  }
}
